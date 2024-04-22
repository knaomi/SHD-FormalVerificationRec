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

  (printf (~a "imem[ 0: 3]: " (vector-ref imem 0) " "
                              (vector-ref imem 1) " "
                              (vector-ref imem 2) " "
                              (vector-ref imem 3) "\n"))
  (printf (~a "imem[ 4: 7]: " (vector-ref imem 4) " "
                              (vector-ref imem 5) " "
                              (vector-ref imem 6) " "
                              (vector-ref imem 7) "\n"))
  (printf (~a "imem[ 8:11]: " (vector-ref imem 8) " "
                              (vector-ref imem 9) " "
                              (vector-ref imem 10) " "
                              (vector-ref imem 11) "\n"))
  (printf (~a "imem[12:15]: " (vector-ref imem 12) " "
                              (vector-ref imem 13) " "
                              (vector-ref imem 14) " "
                              (vector-ref imem 15) "\n"))
)




(define (testMe)
  (define spec (init-spec (vector
    (bv 0 4) (bv 1 4) (bv 0 4) (bv 1 4) (bv 0 4) (bv 1 4) (bv 0 4) (bv 1 4)
    (bv 0 4) (bv 1 4) (bv 0 4) (bv 1 4) (bv 0 4) (bv 1 4) (bv 0 4) (bv 1 4))))
  (printf "===============INIT STATE==============\n")
  (print-spec-imem spec)
  (print-spec spec)
  (printf "\n")

  (for ([i (in-range 10)])
    (step-spec! spec)
    (printf (~a "========= CYCLE" i " =========\n"))
    (print-spec spec)
    (printf "\n")
  )
)

(module+ main
  (testMe))

