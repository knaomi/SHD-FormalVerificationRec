#lang rosette

(require "param.rkt" "init-imem.rkt" "impl.rkt" "spec.rkt")




(define (simu imem PRINT-ON)
  (define impl (init-impl imem))
  (define spec (init-spec imem))
  (when PRINT-ON
    (printf (~a "========= INIT - Impl =========\n"))
    (print-impl impl)
    (printf "\n")
    
    (printf (~a "========= INIT - Spec =========\n"))
    (print-spec spec)
    (printf "\n"))


  (for ([i (in-range param-simuCycle)])
    (step-impl! impl)
    (when PRINT-ON
      (printf (~a "========= CYCLE" i " - Impl =========\n"))
      (print-impl impl)
      (printf "\n"))

    (when (impl-commit impl)
      ; (printf (~a (impl-archState impl) "\n" (spec-archState spec) "\n"))
      (assert (bveq (impl-archState impl) (spec-archState spec)))
      
      (step-spec! spec)
      (when PRINT-ON
        (printf (~a "========= CYCLE" i " - Spec =========\n"))
        (print-spec spec)
        (printf "\n")))
  )
)




(define (veri)

  ; STEP: initialize a symbolic memory, or a concrete memory for debug
  (define imem (if param-concrete-imem (init-concrete-imem)
                                       (init-symbolic-imem)))

  ; STEP: simulate the impl and spec,
  ;       and send the assume and assert to SMT solver
  (define sol (verify (simu imem #f)))

  ; STEP: in case we find a counterexample
  (when (sat? sol)
    (printf (~a "Find Counterexample.\n"))

    ; STEP: based on the counterexample (i.e. sol) generated from SMT solver
    ;       extract the value of imem
    (set! imem (evaluate imem sol))
    (printf (~a "========== Counterexample imem ==========\n"))
    (print-imem imem)
    (printf "\n")

    ; STEP: simulate with the counterexample and print the debug trace
    (simu imem #t)
  )

  ; STEP: in case we do not find a counterexample
  (when (not (sat? sol)) (printf (~a "No Counterexample.\n")))
)




(define (testMe)
  (time (veri))
)



(module+ main
  (testMe))

