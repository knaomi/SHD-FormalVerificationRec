#lang rosette

; REQUIRE: Include some files.
(require "param.rkt" "init-imem.rkt" "../generated_src/tiny_cpu.rkt")

; PROVIDE: If this file is included by another file, the other file will be able
;          to use these functions.
(provide init-impl step-impl! impl-justCommit impl-archState print-impl)




; STRUCT: We define a structure named impl, whose only field saves the state of
;         our tiny_cpu. `#:mutable #:transparent` states you can use functions
;         like set-impl-tiny_cpu! to update it
(struct impl (tiny_cpu) #:mutable #:transparent)




; FUNC: Use imem to initialize a tiny_cpu state and return a impl structure
;       saving it.
(define (init-impl imem)
  ; STEP1: Initialize a new tiny_cpu whose states are all zeros.
  (define tiny_cpu (new-zeroed-tiny_cpu_s))
  
  ; STEP2: Pull up the reset signal and advance cpu state to the next cycle.
  (set! tiny_cpu (step (with-input tiny_cpu (input* 'rst #t))))

  ; STEP3: Overide the instruction memory inside tiny_cpu with imem vector.
  (set! tiny_cpu (update-tiny_cpu_s tiny_cpu
    [imem|[0]|  (vector-ref imem 0)]  [imem|[1]|  (vector-ref imem 1)]
    [imem|[2]|  (vector-ref imem 2)]  [imem|[3]|  (vector-ref imem 3)]
    [imem|[4]|  (vector-ref imem 4)]  [imem|[5]|  (vector-ref imem 5)]
    [imem|[6]|  (vector-ref imem 6)]  [imem|[7]|  (vector-ref imem 7)]
    [imem|[8]|  (vector-ref imem 8)]  [imem|[9]|  (vector-ref imem 9)]
    [imem|[10]| (vector-ref imem 10)] [imem|[11]| (vector-ref imem 11)]
    [imem|[12]| (vector-ref imem 12)] [imem|[13]| (vector-ref imem 13)]
    [imem|[14]| (vector-ref imem 14)] [imem|[15]| (vector-ref imem 15)]))

  ; STEP4: Create a impl structure and return it.
  (impl tiny_cpu)
)




; FUNC: Simulate tiny_cpu by 1 cycle and update the impl data structure.
(define (step-impl! impl)
  ; STEP1: Extract the tiny_cpu field of impl structure.
  (define tiny_cpu (impl-tiny_cpu impl))

  ; STEP2: Advance cpu state to next cycle.
  (set-impl-tiny_cpu! impl (step (with-input tiny_cpu (input* 'rst #f))))
)




; FUNC: Return the justCommit signal in the tiny_cpu.
(define (impl-justCommit impl)
  ; STEP1: Extract the tiny_cpu field of impl structure.
  (define tiny_cpu (impl-tiny_cpu impl))

  ; STEP2: Extract and return the justCommit signal in the output of tiny_cpu.
  (output-justCommit (get-output tiny_cpu))
)




; FUNC: Return the architecture states (i.e. pc, R1, and R2) of the tiny_cpu, as
;       a single bitvector.
(define (impl-archState impl)
  ; *******************
  ; **TODO exercise 3**
  ; *******************
  (bv 0 1)
)




; FUNC: Print out some state of the tiny_cpu.
(define (print-impl impl)
  (define tiny_cpu (impl-tiny_cpu impl))

  ; STEP1: Print whether the implementation just commit an instruction in the
  ;        cycle we just simulated.
  (printf (~a "justCommit: " (impl-justCommit impl) "\n"))
  
  ; STEP2: Print the pc, R1, and R2 of the implementation after the cycle just
  ;        being simulated.
  ; *******************
  ; **TODO exercise 1**
  ; *******************
)




; FUNC: Print out the instruction memory of the tiny_cpu.
(define (print-impl-imem impl)
  (define tiny_cpu (impl-tiny_cpu impl))

  (printf (~a "imem[ 0: 3]: " (tiny_cpu_s-imem|[0]| tiny_cpu) " "
                              (tiny_cpu_s-imem|[1]| tiny_cpu) " "
                              (tiny_cpu_s-imem|[2]| tiny_cpu) " "
                              (tiny_cpu_s-imem|[3]| tiny_cpu) "\n"))
  (printf (~a "imem[ 4: 7]: " (tiny_cpu_s-imem|[4]| tiny_cpu) " "
                              (tiny_cpu_s-imem|[5]| tiny_cpu) " "
                              (tiny_cpu_s-imem|[6]| tiny_cpu) " "
                              (tiny_cpu_s-imem|[7]| tiny_cpu) "\n"))
  (printf (~a "imem[ 8:11]: " (tiny_cpu_s-imem|[8]| tiny_cpu) " "
                              (tiny_cpu_s-imem|[9]| tiny_cpu) " "
                              (tiny_cpu_s-imem|[10]| tiny_cpu) " "
                              (tiny_cpu_s-imem|[11]| tiny_cpu) "\n"))
  (printf (~a "imem[12:15]: " (tiny_cpu_s-imem|[12]| tiny_cpu) " "
                              (tiny_cpu_s-imem|[13]| tiny_cpu) " "
                              (tiny_cpu_s-imem|[14]| tiny_cpu) " "
                              (tiny_cpu_s-imem|[15]| tiny_cpu) "\n"))
)




; FUNC: This is a test function. It initializes a impl structure and simulate
;       the tiny_cpu for a few cycles. It prints out its state at each cycle.
(define (testMe)

  ; STEP1: Initialize a tiny_cpu with instruction memory as a 16-entry vector.
  (define impl (init-impl (vector
    (bv 0 4) (bv 1 4) (bv 0 4) (bv 1 4) (bv 0 4) (bv 1 4) (bv 0 4) (bv 1 4)
    (bv 0 4) (bv 1 4) (bv 0 4) (bv 1 4) (bv 0 4) (bv 1 4) (bv 0 4) (bv 1 4))))

  ; STEP2: Print the initial state of `imem` and `impl`.
  (printf "[simu] INIT\n")
  (printf "********* imem *********\n") (print-impl-imem impl) (printf "\n")
  (printf "********* impl *********\n") (print-impl impl)      (printf "\n")

  ; STEP3: A for loop that simulate the tiny_cpu for 20 cycles.
  (for ([i (in-range 20)])

    ; STEP3.1: Simulate by 1 cycle.
    (printf (~a "[simu] Cycle " (+ i 1) " Start... "))
    (step-impl! impl)
    (printf (~a " ...End\n"))

    ; STEP3.2: Print the state.
    (printf "********* impl *********\n") (print-impl impl) (printf "\n")
  )
)
; NOTE:
; The following line is equivalent to
; if __name__ == "__main__":
;   testMe()
; Specifically, (testMe) is ran only when you execute this file directly
; with command `racket src/impl.rkt`. It will not be ran when you include
; (i.e. require) this file.
(module+ main (testMe))

