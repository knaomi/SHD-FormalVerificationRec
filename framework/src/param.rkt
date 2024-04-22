#lang rosette

(provide (all-defined-out))


(define param-width 4)
(define param-imem-size 16)
(define inst-inc (bv 0 param-width))
(define inst-acc (bv 1 param-width))




(define param-simuCycle 10)
(define param-concrete-imem #f)

; if the printf of a variable is too long, it will be cut into this size
(error-print-width 300)


