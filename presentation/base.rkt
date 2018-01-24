#lang slideshow

(provide function)
(provide keyword)
(provide parameter)
(provide wrapper)
(provide output-footer)

(define (function s)
  (colorize (tt s) "light blue"))

(define (keyword s)
  (colorize (tt s) "blue"))

(define (parameter s)
  (colorize (tt s) "orange"))

(define (wrapper p)
  (rb-superimpose
   (cc-superimpose
    (linewidth 0 (frame (blank client-w client-h) #:color "white"))
    p)
   (bitmap "footer-logo.png")))

(define output-footer (bitmap "footer-logo.png"))
