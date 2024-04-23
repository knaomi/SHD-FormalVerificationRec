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
  (printf (~a "imem[ 0: 3]: " (vector-ref-bv imem (bv 0  4)) " "
                              (vector-ref-bv imem (bv 1  4)) " "
                              (vector-ref-bv imem (bv 2  4)) " "
                              (vector-ref-bv imem (bv 3  4)) "\n"))
  (printf (~a "imem[ 4: 7]: " (vector-ref-bv imem (bv 4  4)) " "
                              (vector-ref-bv imem (bv 5  4)) " "
                              (vector-ref-bv imem (bv 6  4)) " "
                              (vector-ref-bv imem (bv 7  4)) "\n"))
  (printf (~a "imem[ 8:11]: " (vector-ref-bv imem (bv 8  4)) " "
                              (vector-ref-bv imem (bv 9  4)) " "
                              (vector-ref-bv imem (bv 10 4)) " "
                              (vector-ref-bv imem (bv 11 4)) "\n"))
  (printf (~a "imem[12:15]: " (vector-ref-bv imem (bv 12 4)) " "
                              (vector-ref-bv imem (bv 13 4)) " "
                              (vector-ref-bv imem (bv 14 4)) " "
                              (vector-ref-bv imem (bv 15 4)) "\n"))
)

