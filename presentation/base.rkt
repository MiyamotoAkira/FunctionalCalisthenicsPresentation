#lang slideshow

(provide function)
(provide keyword)
(provide parameter)

(define (function s)
  (colorize (tt s) "light blue"))

(define (keyword s)
  (colorize (tt s) "blue"))

(define (parameter s)
  (colorize (tt s) "orange"))
