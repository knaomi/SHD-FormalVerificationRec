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

  ;(step (with-input tiny_cpu (input* ‘rst #t)))

  (define imem (spec-imem spec))
  (define pc (spec-pc spec))
  (define R1 (spec-R1 spec))
  (define R2 (spec-R2 spec))

  (define inst (vector-ref-bv imem pc))
  (printf (~a "instruction:" (vector-ref-bv imem pc) "\n"))
   (cond 
    [(bveq inst inst-inc)
	(set-spec-R1! spec (bvadd1 R1))
	(set-spec-pc! spec (bvadd1 pc)) ]
   [(bveq inst inst-acc) 
        (set-spec-R2! spec (bvadd R1 R2)) 
        (set-spec-pc! spec (bvadd1 pc)) ]
   [else
        (set-spec-pc! spec (bvadd1 pc)) ]  
   ) 
  ; *******************
;  (bv 0 1)
)




(define (spec-archState spec)
  ; *******************
  ; **TODO exercise 3**

  ; *******************


;  (bv 0 1)
 (concat (spec-pc spec) (spec-R1 spec) ( spec-R2 spec))
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

