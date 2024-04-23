#lang rosette

(require "param.rkt" "init-imem.rkt" "impl.rkt" "spec.rkt")




(define (simu imem IS_CONCRETE)

  ; STEP1: Initialize the implementation and specification machines with the
  ;        provided instruction memory.
  (define impl (init-impl imem))
  (define spec (init-spec imem))
  (when IS_CONCRETE
    (printf "[simu] INIT\n")
    (printf "********* impl *********\n") (print-impl impl) (printf "\n")
    (printf "********* spec *********\n") (print-spec spec) (printf "\n")
  )


  ; STEP2: Simulate impl and spec for bounded number of cycles.
  (define commitID 0)
  (for ([i (in-range param-simuCycle)])

    ; STEP2.1: Simulate impl by 1 cycle, when it commits, we also simulate spec
    ;          by 1 cycle.
    (printf (~a "[simu] Cycle " (+ i 1) " Start... "))
    (step-impl! impl)
    (when (impl-justCommit impl) (step-spec! spec))
    (printf (~a " ...End\n"))

    ; STEP2.2: When we simulate with concrete initial states, ...
    (when IS_CONCRETE
      
      ; STEP2.2: ... and the impl just commit an instruction, ...
      (when (impl-justCommit impl)

        ; STEP2.2.1: Print out the state of the impl and spec.
        (set! commitID (+ commitID 1))
        (printf (~a "********* impl after " commitID "-th commit *********\n"))
        (print-impl impl) (printf "\n")
        (printf (~a "********* spec after " commitID "-th commit *********\n"))
        (print-spec spec) (printf "\n")

        ; STEP2.2.2: If the architecture state mismatch, alert and quit.
        (when (not (bveq (impl-archState impl) (spec-archState spec)))
          (printf (~a "********* Arch State Mismatch Found *********\n"))
          (exit)))
    )

    ; STEP2.3: We assert impl and spec should have same architectural state
    ;          when impl just committed an instruction.
    (when (impl-justCommit impl)
      (assert (bveq (impl-archState impl) (spec-archState spec))))
  )
)




(define (veri)

  ; STEP1: Initialize a symbolic instruction memory, or a concrete instruction
  ;        memory for debug.
  (define imem (cond
    [(equal? param-imem-type "concrete")
      (init-concrete-imem)]
    [(equal? param-imem-type "sym")
      (init-symbolic-imem)]))


  ; STEP2: Simulate the impl and spec (i.e., `simu`) during which, assertions
  ;        are collected by the `verify` function. After the simulation,
  ;        `verify` also send all assertions to a SMT solver, asking for
  ;        solution (i.e., `sol`). Solution is basically a counterexample
  ;        violating one of the assertions.
  (printf (~a
    "==================================\n"
    "==== Start Symbolic Execution ====\n"
    "==================================\n"))
  (define sol (verify (simu imem #f)))
  (printf (~a "\n"))


  ; STEP3: In case we find a counterexample (we call it satisfiable), ...
  (when (sat? sol)

    ; STEP3.1: Based on the counterexample (i.e. `sol`) generated from the SMT
    ;          solver, print out the value of `imem`.
    ;          `(evaluate imem sol)` means `evaluate` a `sol` and get the
    ;          concrete value of `imem`.
    (printf (~a
      "==============================\n"
      "==== Counterexample Found ====\n"
      "==============================\n"))
    (print-imem (evaluate imem sol))
    (printf "\n")

    ; STEP4.2: Simulate with the counterexample and print the debug trace.
    (set! imem (evaluate imem sol))
    (printf (~a
      "=============================================\n"
      "==== Start Simulating the Counterexample ====\n"
      "=============================================\n"))
    (simu imem #t)
    (printf (~a "\n"))
  )

  ; STEP5: In case we do not find a counterexample, ...
  (when (not (sat? sol)) 
    (printf (~a
      "===========================\n"
      "==== No Counterexample ====\n"
      "===========================\n"
      "\n"))
  )
)





(define (testMe)
  (time (veri))
)
(module+ main (testMe))

