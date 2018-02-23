#lang slideshow

(require "base.rkt")

(provide declarations-clojure)
(provide bad-naming-clojure)
(provide good-naming-clojure)
(provide statement-clojure)
(provide expression-clojure)
(provide mutable-state-clojure)
(provide non-mutable-state-clojure)
(provide non-exhaustive-1-clojure)
(provide exhaustive-1-clojure)
(provide non-exhaustive-2-clojure)
(provide exhaustive-2-clojure)
(provide intermediate-variables-clojure)
(provide non-intermediate-variables-clojure)
(provide non-intermediate-variables-alternate-clojure)
(provide justification-clojure)
(provide recursion-clojure)
(provide non-recursion-clojure)
(provide non-recursion-alternate-clojure)
(provide non-generic-building-block-clojure)
(provide generic-building-block-clojure)
(provide generic-building-block-alternate-clojure)
(provide side-effect-clojure)
(provide side-effect-injection-clojure)
(provide side-effect-out-clojure)
(provide side-effect-out-alternate-clojure)
(provide non-sequence-clojure)
(provide sequence-clojure)
(provide multiple-arguments-clojure)
(provide single-argument-clojure)
(provide multiple-arguments-2-clojure)
(provide composition-clojure)
(provide piping-clojure)

(define (color-picker depth)
  (match depth
    [1 "chocolate"]
    [2 "firebrick"]
    [3 "steel blue"]
    [4 "orange"]
    [5 "purple"]
    [_ "green"]))

(define (color-bracket bracket depth)
  (colorize (tt bracket) (color-picker depth)))

(define (open-p depth)
  (color-bracket "(" depth))

(define (close-p depth)
  (color-bracket ")" depth))

(define (open-s depth)
  (color-bracket "[" depth))

(define (close-s depth)
  (color-bracket "]" depth))

(define (defn) (keyword "defn"))

(define (space) (tt " "))

(define (tab) (tt "  "))

(define (declarations-clojure)
  (vl-append
   0
   (hbl-append 0 (open-p 1) (keyword "def") (space) (tt "neighbours"))
   (hbl-append 0
               (tab) (open-s 2)
               (open-s 3) (tt "-1 -1") (close-s 3)
               (open-s 3) (tt "-1 0") (close-s 3)
               (open-s 3) (tt "-1 1") (close-s 3)
               (open-s 3) (tt "0 -1") (close-s 3))
   (hbl-append 0
               (tab) (space)
               (open-s 3) (tt "0 1") (close-s 3)
               (open-s 3) (tt "1 -1") (close-s 3)
               (open-s 3) (tt "1 0") (close-s 3)
               (open-s 3) (tt "1 1") (close-s 3)
               (close-s 2) (close-p 1))))

(define (bad-naming-clojure)
  (vl-append
   0
   (hbl-append 0 (open-p 1) (defn) (space) (function "new-cell-status"))
   (hbl-append 0 (tab) (open-s 2) (tt "universe cell") (close-s 2))
   (hbl-append 0
               (tab) (open-p 2) (keyword "let") (space)
               (open-s 3) (tt "size") (space) (open-p 4) (tt "count"))
   (hbl-append 0
               (tab) (tab) (tab) (tab) (tab) (tab) (tab) (tab)
               (open-p 5) (tt "find-alive-neighbours"))
   (hbl-append 0 (tab) (tab) (tab) (tab) (tab) (tab) (tab) (tab) (space)
               (tt "universe cell") (close-p 5) (close-p 4) (close-s 3))
   (hbl-append 0
               (tab) (tab) (open-p 3) (tt "or")
               (space) (open-p 4) (tt "= 2 size") (close-p 4)
               (space) (open-p 4) (tt "= 3 size") (close-p 4)
               (close-p 3) (close-p 2) (close-p 1))))

(define (good-naming-clojure)
  (vl-append
   0
   (hbl-append 0 (open-p 1) (defn) (space) (function "rule-alive"))
   (hbl-append 0 (tab) (open-s 2) (tt "size") (close-s 2))
   (hbl-append 0
               (tab)
               (open-p 2) (tt "or")
               (space) (open-p 3) (tt "= 2 size") (close-p 3)
               (space) (open-p 3) (tt "= 3 size") (close-p 3)
               (close-p 2)
               (close-p 3))
   (tt "")
   (hbl-append 0 (open-p 1) (defn) (space) (function "new-cell-status"))
   (hbl-append 0 (tab) (open-s 2) (tt "universe cell") (close-s 2))
   (hbl-append 0
               (tab) (open-p 2) (keyword "let") (space)
               (open-s 3) (tt "size") (space) (open-p 4) (tt "count"))
   (hbl-append 0
               (tab) (tab) (tab) (tab) (tab) (tab) (tab) (tab)
               (open-p 5) (tt "find-alive-neighbours"))
   (hbl-append 0 (tab) (tab) (tab) (tab) (tab) (tab) (tab) (tab) (space)
               (tt "universe cell") (close-p 5) (close-p 4) (close-s 3))
   (hbl-append 0
               (tab) (tab) (open-p 3) (tt "rule-alive size")
               (close-p 3) (close-p 2) (close-p 1))))

(define (statement-clojure)
  (vl-append
   0
   (hbl-append 0
               (open-p 1) (keyword "let") (space)
               (open-s 2) (tt "result") (space)
               (open-p 3) (tt "some-calculation some-parameter") (close-p 3) (close-s 2))
   (hbl-append 0 (space) (open-p 2) (tt "another-call result") (close-p 2) (close-p 1))))

(define (expression-clojure)
  (vl-append
   0
   (hbl-append 0
               (open-p 1) (tt "another-call") (space)
               (open-p 2) (tt "some-calculation some-paramater")
               (close-p 2) (close-p 1))))

(define (mutable-state-clojure)
  (vl-append
   0
   (hbl-append 0
               (open-p 1) (keyword "def") (space) (tt "universe") (space)
               (open-p 2) (tt "atom") (space)
               (open-s 3)
               (open-s 4) (tt "1 0") (close-s 4)
               (open-s 4) (tt "1 0") (close-s 4)
               (open-s 4) (tt "1 0") (close-s 4)
               (close-s 3) (close-p 2) (close-p 1))))

(define (non-mutable-state-clojure)
  (vl-append
   0
   (hbl-append 0
               (open-p 1) (keyword "def") (space) (tt "universe") (space)
               (open-s 2)
               (open-s 3) (tt "1 0") (close-s 3)
               (open-s 3) (tt "1 0") (close-s 3)
               (open-s 3) (tt "1 0") (close-s 3)
               (close-s 2) (close-p 1))))

(define (non-exhaustive-1-clojure)
  (vl-append
   0
   (hbl-append 0 (open-p 1) (defn) (space) (function "rule-alive"))
   (hbl-append 0 (tab) (open-s 2) (tt "size") (close-s 2))
   (hbl-append 0 (tab) (open-p 2) (tt "match") (space) (tt "size"))
   (hbl-append 0 (tab) (tab) (open-s 3) (tt "2") (close-s 3) (space) (tt "true"))
   (hbl-append 0
               (tab) (tab) (open-s 3) (tt "3") (close-s 3) (space) (tt "true")
               (close-p 2) (close-p 1))))

(define (exhaustive-1-clojure)
  (vl-append
   0
   (hbl-append 0 (open-p 1) (defn) (space) (function "rule-alive"))
   (hbl-append 0 (tab) (open-s 2) (tt "size") (close-s 2))
   (hbl-append 0 (tab) (open-p 2) (tt "match") (space) (open-s 3) (tt "size") (close-s 3))
   (hbl-append 0 (tab) (tab) (open-s 3) (tt "2") (close-s 3) (space) (tt "true"))
   (hbl-append 0 (tab) (tab) (open-s 3) (tt "3") (close-s 3) (space) (tt "true"))

   (hbl-append 0 (tab) (tab) (keyword ":else") (space) (tt "false")
               (close-p 2) (close-p 1))))

(define (non-exhaustive-2-clojure)
  (vl-append
   0
   (hbl-append 0 (open-p 1) (defn) (space) (function "rule-born"))
   (hbl-append 0 (tab) (open-s 2) (tt "neighbours") (close-s 2))
   (hbl-append 0
               (tab) (open-p 2) (keyword "if") (space)
               (open-p 3) (tt"= 3 neighbours") (close-p 3) (space) (tt "true")
               (close-p 2) (close-p 1))))

(define (exhaustive-2-clojure)
  (vl-append
   0
   (hbl-append 0 (open-p 1) (defn) (space) (function "rule-born"))
   (hbl-append 0 (tab) (open-s 2) (tt "neighbours") (close-s 2))
   (hbl-append 0
               (tab) (open-p 2) (keyword "if") (space)
               (open-p 3) (tt"= 3 neighbours") (close-p 3) (space) (tt "true false")
               (close-p 2) (close-p 1))))

(define (intermediate-variables-clojure)
  (vl-append
   0
   (hbl-append 0 (open-p 1) (defn) (space) (function "new-cell-status"))
   (hbl-append 0 (tab) (open-s 2) (tt "universe cell") (close-s 2))
   (hbl-append 0
               (tab) (open-p 2) (keyword "let") (space)
               (open-s 3) (tt "size") (space) (open-p 4) (tt "count"))
   (hbl-append 0
               (tab) (tab) (tab) (tab) (tab) (tab) (tab) (tab)
               (open-p 5) (tt "find-alive-neighbours"))
   (hbl-append 0 (tab) (tab) (tab) (tab) (tab) (tab) (tab) (tab) (space)
               (tt "universe cell") (close-p 5) (close-p 4) (close-s 3))
   (hbl-append 0
               (tab) (tab) (open-p 3) (tt "rule-alive size")
               (close-p 3) (close-p 2) (close-p 1))))

(define (non-intermediate-variables-clojure)
  (vl-append
   0
   (hbl-append 0 (open-p 1) (defn) (space) (function "new-cell-status"))
   (hbl-append 0 (tab) (open-s 2) (tt "universe cell") (close-s 2))
   (hbl-append 0
               (tab) (open-p 2) (tt "rule-alive"))
   (hbl-append 0 (tab) (tab) (open-p 3) (tt "count") (space))
   (hbl-append 0
               (tab) (tab) (tab) (open-p 4) (tt "find-alive-neighbours"))
   (hbl-append 0 (tab) (tab) (tab) (tab) (space)
               (tt "universe cell") (close-p 4) (close-p 3) (close-p 2) (close-p 1))))

(define (non-intermediate-variables-alternate-clojure)
  (vl-append
   0
   (hbl-append 0 (open-p 1) (defn) (space) (function "new-cell-status"))
   (hbl-append 0 (tab) (open-s 2) (tt "cell universe") (close-s 2))
   (hbl-append 0 (tab) (open-p 2) (tt "-> ") (open-p 3) (tt "find-alive-neighbours universe cell") (close-p 3))
   (hbl-append 0 (tab) (tab) (tab) (tt "count"))
   (hbl-append 0 (tab) (tab) (tab) (tt "rule-alive") (close-p 2) (close-p 1))))

(define (justification-clojure)
  (vl-append
   0
   (hbl-append 0 (open-p 1) (defn))
   (hbl-append 0 (tab) (open-p 2) (keyword "let") (space) (open-s 3))
   (hbl-append 0 (tab) (tab) (open-p 3) (keyword "if-let") (space) (open-s 4))
   (hbl-append 0 (tab) (tab) (tab) (open-p 4) (keyword "do"))
   (hbl-append 0 (tab) (tab) (tab) (tab) (open-p 5) (keyword "let") (space) (open-s 6))
   (hbl-append 0 (tab) (tab) (tab) (tab) (tab) (open-p 6) (keyword "if"))
   (hbl-append 0 (tab) (tab) (tab) (tab) (tab) (tab) (open-p 7) (keyword "let") (open-s 8))))

(define (recursion-clojure)
  (vl-append
   0
   (hbl-append 0 (open-p 1) (defn) (space) (function "get-neighbours"))
   (hbl-append 0 (tab) (open-s 2) (tt "cell") (close-s 2))
   (hbl-append 0
               (tab) (open-p 2) (keyword "loop") (space)
               (open-s 3) (tt "neighbour") (space)
               (open-p 4) (tt "first neighbours") (close-p 4))
   (hbl-append 0
               (tab) (tab) (tab) (tab) (space) (tt "rest-n") (space)
               (open-p 4) (tt "rest neighbours") (close-p 4))
   (hbl-append 0
               (tab) (tab) (tab) (tab) (space) (tt "result") (space)
               (open-s 4) (close-s 4) (close-s 3))
   (hbl-append 0 (tab) (open-p 3) (keyword "if-not") (space) (tt "neighbour"))
   (hbl-append 0 (tab) (tab) (tt "result"))
   (hbl-append 0 (tab) (tab) (open-p 4) (tt "recur"))
   (hbl-append 0 (tab) (tab) (tab) (open-p 5) (tt "first rest-n") (close-p 5))
   (hbl-append 0 (tab) (tab) (tab) (open-p 5) (tt "rest rest-n") (close-p 5))
   (hbl-append 0 (tab) (tab) (tab) (open-p 5) (tt "conj result"))
   (hbl-append 0
               (tab) (tab) (tab) (tab)
               (open-p 6) (tt "add-for-neighbour cell neighbour")
               (close-p 6) (close-p 5) (close-p 4) (close-p 3) (close-p 2) (close-p 1))))

(define (non-recursion-clojure)
  (vl-append
   0
   (hbl-append 0 (open-p 1) (defn) (space) (function "get-neighbours"))
   (hbl-append 0 (tab) (open-s 2) (tt "cell") (close-s 2))
   (hbl-append 0
               (tab)
               (open-p 2) (tt "map") (space)
               (keyword "#") (open-p 3)
               (tt "add-for-neighbour cell ") (keyword "%") (close-p 3) (space)
               (tt "neighbours") (close-p 2) (close-p 1))))

(define (non-recursion-alternate-clojure)
  (vl-append
   0
   (hbl-append 0 (open-p 1) (defn) (space) (function "get-neighbours"))
   (hbl-append 0 (tab) (open-s 2) (tt "cell") (close-s 2))
   (hbl-append 0
               (tab)
               (open-p 2) (tt "map") (space)
               (keyword "#") (open-p 3)
               (tt "add-for-neighbour cell ") (keyword "%") (close-p 3) (space)
               (tt "neighbours") (close-p 2) (close-p 1))))

(define (non-generic-building-block-clojure)
  (vl-append
   0
   (hbl-append 0 (open-p 1) (defn) (space) (function "new-cell-status"))
   (hbl-append 0 (tab) (open-s 2) (tt "universe cell") (close-s 2))
   (hbl-append 0 (tab) (open-p 2) (tt "-> ") (open-p 3) (tt "find-alive-neighbours universe cell") (close-p 3))
   (hbl-append 0 (tab) (tab) (tab) (tt "count"))
   (hbl-append 0 (tab) (tab) (tab) (tt "rule-alive") (close-p 2) (close-p 1))))

(define (generic-building-block-clojure)
  (vl-append
   0
   (hbl-append 0 (open-p 1) (defn) (space) (function "new-cell-status"))
   (hbl-append 0 (tab) (open-s 2) (tt "universe cell rule") (close-s 2))
   (hbl-append 0 (tab) (open-p 2) (tt "-> ") (open-p 3) (tt "find-alive-neighbours universe cell") (close-p 3))
   (hbl-append 0 (tab) (tab) (tab) (tt "count"))
   (hbl-append 0 (tab) (tab) (tab) (tt "rule") (close-p 2) (close-p 1))))

(define (generic-building-block-alternate-clojure)
  (vl-append
   0
   (hbl-append 0 (open-p 1) (defn) (space) (function "new-cell-status"))
   (hbl-append 0 (tab) (open-s 2) (tt "cell universe rule") (close-s 2))
   (hbl-append 0 (tab) (open-p 2) (tt "-> ") (open-p 3) (tt "find-alive-neighbours universe cell") (close-p 3))
   (hbl-append 0 (tab) (tab) (tab) (tt "count"))
   (hbl-append 0 (tab) (tab) (tab) (tt "rule") (close-p 2) (close-p 1))))

(define (side-effect-clojure)
  (vl-append
   0
   (hbl-append 0 (open-p 1) (defn) (space) (function "save-new-borns"))
   (hbl-append 0 (tab) (open-s 2) (tt "new-borns") (close-s 2))
   (hbl-append 0 (tt "  ... saving on db ...") (close-p 1))
   (hbl-append 0 (tt ""))
   (hbl-append 0 (open-p 1) (defn) (space) (function "find-new-borns"))
   (hbl-append 0 (tab) (open-s 2) (tt "universe") (close-s 2))
   (hbl-append 0
               (tab) (tt "...")
               (open-p 3) (tt "save-new-borns all-found") (close-p 3)
               (tt "...") (close-p 1))))

(define (side-effect-injection-clojure)
  (vl-append
   0
   (hbl-append 0 (open-p 1) (defn) (space) (function "save-new-borns"))
   (hbl-append 0 (tab) (open-s 2) (tt "new-borns") (close-s 2))
   (hbl-append 0 (tt "  ... saving on db ...") (close-p 1))
   (hbl-append 0 (tt ""))
   (hbl-append 0 (open-p 1) (defn) (space) (function "find-new-borns"))
   (hbl-append 0 (tab) (open-s 2) (tt "universe save") (close-s 2))
   (hbl-append 0
               (tab) (tt "...")
               (open-p 3) (tt "save all-found") (close-p 3)
               (tt "...") (close-p 1))))

(define (side-effect-out-clojure)
  (vl-append
   0
   (hbl-append 0 (open-p 1) (defn) (space) (function "save-new-borns"))
   (hbl-append 0 (tab) (open-s 2) (tt "new-borns") (close-s 2))
   (hbl-append 0 (tt "  ... saving on db ...") (close-p 1))
   (hbl-append 0 (tt ""))
   (hbl-append 0 (open-p 1) (defn) (space) (function "find-new-borns"))
   (hbl-append 0 (tab) (open-s 2) (tt "universe") (close-s 2))
   (hbl-append 0 (tt "  ..."))
   (hbl-append 0 (tt "  all-found") (close-p 1))
   (hbl-append 0 (tt ""))
   (hbl-append 0 (open-p 1) (defn) (space) (function "main"))
   (hbl-append 0 (tab) (tt "..."))
   (hbl-append 0 (tab) (open-p 3) (tt "-> universe"))
   (hbl-append 0 (tab) (tab) (space) (tt "find-new-borns"))
   (hbl-append 0 (tab) (tab) (space) (tt "save-new-borns") (close-p 1))))

(define (side-effect-out-alternate-clojure)
  (vl-append
   0
   (hbl-append 0 (open-p 1) (defn) (space) (function "save-new-borns"))
   (hbl-append 0 (tab) (open-s 2) (tt "new-borns") (close-s 2))
   (hbl-append 0 (tt "  ... saving on db ...") (close-p 1))
   (hbl-append 0 (tt ""))
   (hbl-append 0 (open-p 1) (defn) (space) (function "find-new-borns"))
   (hbl-append 0 (tab) (open-s 2) (tt "universe") (close-s 2))
   (hbl-append 0 (tt "  ..."))
   (hbl-append 0 (tt "  all-found") (close-p 1))
   (hbl-append 0 (tt ""))
   (hbl-append 0 (open-p 1) (defn) (space) (function "main"))
   (hbl-append 0 (tab) (tt "..."))
   (hbl-append 0 (tab) (open-p 3) (tt "-> universe"))
   (hbl-append 0 (tab) (tab) (space) (tt "find-new-borns"))
   (hbl-append 0 (tab) (tab) (space) (tt "save-new-borns") (close-p 1))))

(define (non-sequence-clojure)
  (vl-append
   0
   (hbl-append 0 (open-p 1) (defn) (space) (function "find-alive-neighbours"))
   (hbl-append 0 (tab) (open-s 2) (tt "cell universe") (close-s 2))
   (hbl-append 0
               (tab) (open-p 2) (tt "filterv") (space) (keyword "#")
               (open-p 3) (tt "is-neighbour cell") (space) (keyword "%") (close-p 3) (space)
               (tt "universe") (close-p 2) (close-p 1))))

(define (sequence-clojure)
  (vl-append
   0
   (hbl-append 0 (open-p 1) (defn) (space) (function "find-alive-neighbours"))
   (hbl-append 0 (tab) (open-s 2) (tt "cell universe") (close-s 2))
   (hbl-append 0
               (tab) (open-p 2) (tt "filter") (space) (keyword "#")
               (open-p 3) (tt "is-neighbour cell") (space) (keyword "%") (close-p 3) (space)
               (tt "universe") (close-p 2) (close-p 1))))

(define (multiple-arguments-clojure)
  (vl-append
   0
   (hbl-append 0 (open-p 1) (defn) (space) (function "add-for-neighbour"))
   (hbl-append 0 (tab) (open-s 2) (tt "cell neighbour") (close-s 2))
   (hbl-append 0
               (tab) (open-p 2) (tt "vector") (space)
               (open-p 3) (tt "+") (space) (open-p 4) (tt "first cell") (close-p 4) (space)
               (open-p 4) (tt "first neighbour") (close-p 4) (close-p 3))
   (hbl-append 0 (tab) (tab) (tab) (tab) (tab)
               (open-p 3) (tt "+") (space)
               (open-p 4) (tt "second cell") (close-p 4) (space)
               (open-p 4) (tt "second neighbour")
               (close-p 4) (close-p 3) (close-p 2) (close-p 1))
   (hbl-append 0 (tt ""))
   (hbl-append 0 (open-p 1) (defn) (space) (function "get-neighbours"))
   (hbl-append 0 (tab) (open-s 2) (tt "cell") (close-s 2))
   (hbl-append 0
               (tab) (open-p 2) (tt "map") (space) (keyword "#")
               (open-p 3) (tt "add-for-neighbour cell") (space) (keyword "%") (close-p 3) (space)
               (tt "neighbours") (close-p 2) (close-p 1))))

(define (single-argument-clojure)
  (vl-append
   0
   (hbl-append 0 (open-p 1) (defn) (space) (function "add-for-neighbour"))
   (hbl-append 0 (tab) (open-s 2) (tt "cell neighbour") (close-s 2))
   (hbl-append 0
               (tab) (open-p 2) (tt "vector") (space)
               (open-p 3) (tt "+") (space)
               (open-p 4) (tt "first cell") (close-p 4) (space)
               (open-p 4) (tt "first neighbour") (close-p 4) (close-p 3))
   (hbl-append 0 (tab) (tab) (tab) (tab) (tab)
               (open-p 3) (tt "+") (space)
               (open-p 4) (tt "second cell") (close-p 4) (space)
               (open-p 4) (tt "second neighbour")
               (close-p 4) (close-p 3) (close-p 2) (close-p 1))
   (hbl-append 0 (tt ""))
   (hbl-append 0 (open-p 1) (defn) (space) (function "get-neighbours"))
   (hbl-append 0 (tab) (open-s 2) (tt "cell") (close-s 2))
   (hbl-append 0
               (tab) (open-p 2) (keyword "let") (space)
               (open-s 3) (tt "add-for") (space)
               (open-p 4) (keyword "partial") (space) (tt "add-for-neighbour cell")
               (close-p 4) (close-s 3))
   (hbl-append 0
               (tab) (tab) (open-p 2) (tt "map") (space)
                (tt "add-for") (space)
                (tt "neighbours") (close-p 2) (close-p 1))))

(define (multiple-arguments-2-clojure)
  (vl-append
   0
   (hbl-append 0 (open-p 1) (defn) (space) (function "new-cell-status"))
   (hbl-append 0 (tab) (open-s 2) (tt "universe cell") (close-s 2))
   (hbl-append 0 (tab) (open-p 2) (tt "rule-alive"))
   (hbl-append 0
               (tab) (tab) (open-p 3) (tt "count") (space)
               (open-p 4) (tt "find-alive-neighbours universe cell")
               (close-p 4) (close-p 3) (close-p 2) (close-p 1))))

(define (composition-clojure)
  (vl-append
   0
   (hbl-append 0 (open-p 1) (keyword "def") (space) (tt "is-alive?"))
   (hbl-append 0
               (tab) (open-p 2) (keyword "comp") (space)
               (tt "rule-alive count find-alive-neighbours")
               (close-p 2) (close-p 1))
   (hbl-append 0 (tt ""))
   (hbl-append 0 (open-p 1) (defn) (space) (function "new-cell-status"))
   (hbl-append 0 (tab) (open-s 2) (tt "cell universe") (close-s 2))
   (hbl-append 0 (tab) (open-p 2) (tt "is-alive? universe cell") (close-p 2) (close-p 1))))

(define (piping-clojure)
  (vl-append
   0
   (hbl-append 0 (open-p 1) (keyword "def") (space) (tt "is-alive?"))
   (hbl-append 0 (tab) (open-s 2) (tt "universe cell") (close-s 2))
   (hbl-append 0 (tab) (open-p 2) (tt "-> universe"))
   (hbl-append 0 (tab) (tab) (tab) (open-p 3) (tt "find-alive-neighbours cell") (close-p 3))
   (hbl-append 0 (tab) (tab) (tab) (tt "rule-alive"))
   (hbl-append 0 (tab) (tab) (tab) (tt "count") (close-p 2) (close-p 1))
   (hbl-append 0 (tt ""))
   (hbl-append 0 (open-p 1) (defn) (space) (function "new-cell-status"))
   (hbl-append 0 (tab) (open-s 2) (tt "cell universe") (close-s 2))
   (hbl-append 0 (tab) (open-p 2) (tt "is-alive? universe cell") (close-p 2) (close-p 1))))
