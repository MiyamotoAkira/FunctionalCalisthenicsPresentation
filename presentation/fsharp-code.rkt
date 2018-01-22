#lang slideshow

(require "base.rkt")

(provide letk)
(provide equal)
(provide tab)
(provide declarations-fsharp)

(define (letk) (keyword "let "))

(define (equal) (keyword "= "))

(define (tab) (tt "    "))

(define (declarations-fsharp)
  (vc-append 0 (hbl-append 0 (keyword "type ") (function "Cell ") (equal) (keyword "{") (tt "x") (keyword ": int; ") (tt "y") (keyword ": int}") )
        (tt "")
        (hbl-append 0
                    (keyword "let ")
                    (function "neighbours ")
                    (keyword "= [")
                    (tt "(-1,-1)")
                    (keyword "; ")
                    (tt "(0,-1)")
                    (keyword "; ")
                    (tt "(1,-1)")
                    (keyword "; ")
                    (tt "(-1,0)")
                    (keyword "; "))
        (hbl-append 0
                    (tt "                  ")
                    (tt "(1,0)")
                    (keyword "; ")
                    (tt "(-1,1)")
                    (keyword "; ")
                    (tt "(0,1)")
                    (keyword "; ")
                    (tt "(1,1)")
                    (keyword ";]"))))
