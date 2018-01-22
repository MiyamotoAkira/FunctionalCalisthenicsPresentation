#lang slideshow

(provide function)
(provide keyword)
(provide parameter)
(provide letk)
(provide equal)
(provide tab)

(define (function s)
  (colorize (tt s) "light blue"))

(define (keyword s)
  (colorize (tt s) "blue"))

(define (parameter s)
  (colorize (tt s) "orange"))

(define (letk) (keyword "let "))

(define (equal) (keyword "= "))

(define (tab) (tt "    "))
