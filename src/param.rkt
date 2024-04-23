#lang rosette

(require rosette/solver/smt/z3 rosette/solver/smt/boolector)
(provide (all-defined-out))


; STEP1: ISA definitions.
(define param-width 4)
(define param-imem-size 16)
(define inst-inc (bv 0 param-width))
(define inst-acc (bv 1 param-width))




; STEP2: We use boolector as the solver back-end.
;        We found it is faster than z3 in our use case.
(current-solver (boolector)) ; choose between: z3, boolector




; STEP3: Number of cycle to simulate.
(define param-simuCycle 10)




; STEP4: Initialize the instruction memory to either concrete value (for debug)
;        or symbolic value (for verification).
(define param-imem-type "sym") ; choose between: concrete, sym




; STEP5: If the printf of a variable is too long, it will be cut into this size.
(error-print-width 300)

