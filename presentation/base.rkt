#lang slideshow

(provide function)
(provide keyword)
(provide parameter)
(provide output-footer)
(provide wrapper)
(provide wrapper-titleless)

(define (function s)
  (colorize (tt s) "light blue"))

(define (keyword s)
  (colorize (tt s) "blue"))

(define (parameter s)
  (colorize (tt s) "orange"))

(define output-footer (bitmap "footer-logo.png"))

(define (wrapper p)
  (rb-superimpose
   (cc-superimpose
    (linewidth 0 (frame (blank client-w client-h) #:color "white"))
    p)
   output-footer))

(define (wrapper-titleless p)
  (rb-superimpose
   (cc-superimpose
    (linewidth 0 (frame (titleless-page) #:color "white"))
    p)
   output-footer))


