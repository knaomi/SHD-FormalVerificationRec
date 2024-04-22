#lang rosette

(require "param.rkt")

(provide init-concrete-imem init-symbolic-imem print-imem)


(define (init-concrete-imem)
  (vector
    (bv 0 4) (bv 1 4) (bv 0 4) (bv 1 4) (bv 0 4) (bv 1 4) (bv 0 4) (bv 1 4)
    (bv 0 4) (bv 1 4) (bv 0 4) (bv 1 4) (bv 0 4) (bv 1 4) (bv 0 4) (bv 1 4))
)




(define (init-symbolic-imem)
  (define (build-symbv size)
    (define-symbolic* symbv (bitvector size))
    symbv)

  (vector
    (build-symbv param-width) (build-symbv param-width)
    (build-symbv param-width) (build-symbv param-width)
    (build-symbv param-width) (build-symbv param-width)
    (build-symbv param-width) (build-symbv param-width)
    (build-symbv param-width) (build-symbv param-width)
    (build-symbv param-width) (build-symbv param-width)
    (build-symbv param-width) (build-symbv param-width)
    (build-symbv param-width) (build-symbv param-width))
)




(define (print-imem imem)
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

