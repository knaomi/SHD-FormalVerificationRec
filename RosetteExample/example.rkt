#lang rosette                ; # Here is a python version:


; PART1
(printf "--------PART1--------\n")
(define (f x y)              ; def f(x, y):
  (when (= (* (+ x 10) 2) y) ;   if (x+10)*2 == y:
    (assert #f)))            ;     assert False

(f 1 10)                     ; f(1, 10)


(define-symbolic x integer?)
(define-symbolic y integer?)
(verify (f x y))
(printf "\n")




; PART2
(printf "--------PART2--------\n")
(println (* (+ 1 10) 2))
(println (* (+ x 10) 2))
(printf "\n")





; PART3
(printf "--------PART3--------\n")
(if (= x 0)
  (printf (~a "Path1: " (vc-assumes (vc)) "\n"))
  (printf (~a "Path2: " (vc-assumes (vc)) "\n")))
(printf "\n")





; PART4
(printf "--------PART4--------\n")
(define (g x y)
  (when (= x 0)
    (assert (= x y)))
  (println (vc-asserts (vc))))
(verify (g x y))
(printf "\n")


