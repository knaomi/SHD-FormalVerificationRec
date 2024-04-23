#lang rosette

(require "param.rkt" "init-imem.rkt")

(provide init-spec step-spec! spec-archState print-spec)




(struct spec (imem pc R1 R2) #:mutable #:transparent)




(define (init-spec imem)
  (spec
    (vector-copy imem)
    (bv 0 param-width)
    (bv 0 param-width)
    (bv 0 param-width))
)




(define (step-spec! spec)
  ; *******************
  ; **TODO exercise 2**
  ; *******************
  (bv 0 1)
)




(define (spec-archState spec)
  ; *******************
  ; **TODO exercise 3**
  ; *******************
  (bv 0 1)
)




(define (print-spec spec)
  (define pc (spec-pc spec))
  (define R1 (spec-R1 spec))
  (define R2 (spec-R2 spec))
  
  (printf (~a "pc: " pc ", "))
  (printf (~a "R1: " R1 ", "))
  (printf (~a "R2: " R2 "\n"))
  (printf "\n")
)




(define (print-spec-imem spec)
  (define imem (spec-imem spec))

  (print-imem imem)
)




(define (testMe)
  (define spec (init-spec (vector
    (bv 0 4) (bv 1 4) (bv 0 4) (bv 1 4) (bv 0 4) (bv 1 4) (bv 0 4) (bv 1 4)
    (bv 0 4) (bv 1 4) (bv 0 4) (bv 1 4) (bv 0 4) (bv 1 4) (bv 0 4) (bv 1 4))))
  
  (printf "[simu] INIT\n")
  (printf "********* imem *********\n") (print-spec-imem spec) (printf "\n")
  (printf "********* spec *********\n") (print-spec spec)      (printf "\n")

  (for ([i (in-range 10)])
    (printf (~a "[simu] Cycle " (+ i 1) " Start... "))
    (step-spec! spec)
    (printf (~a " ...End\n"))

    (printf "********* spec *********\n") (print-spec spec) (printf "\n")
  )
)
(module+ main (testMe))

