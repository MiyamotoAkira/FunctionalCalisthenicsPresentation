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
   (hbl-append 0 (open-p 1) (defn) (space) (function "neighbours"))
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
   (hbl-append 0 (tab) (open-s 2) (tt "cell universe") (close-s 2))
   (hbl-append 0
               (tab) (open-p 2) (keyword "let") (space)
               (open-s 3) (tt "count") (space) (open-p 4) (tt "count"))
   (hbl-append 0
               (tab) (tab) (tab) (tab) (tab) (tab) (tab)
               (open-p 5) (tt "find-alive-neighbours"))
   (hbl-append 0 (tab) (tab) (tab) (tab) (tab) (tab) (tab) (tab) (space)
               (tt "cell universe") (close-p 5) (close-p 4) (close-s 3))
   (hbl-append 0
               (tab) (open-p 3) (tt "or")
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
   (hbl-append 0 (open-p 1) (defn) (space) (tt "new-cell-status"))
   (hbl-append 0 (tab) (open-s 2) (tt "cell universe") (close-s 2))
   (hbl-append 0 (tab) (open-p 2) (tt "rule-alive"))
   (hbl-append 0
               (tab) (tab)
               (open-p 3) (tt "count") (space) (open-p 4) (tt "find-alive-neighbours"))
   (hbl-append 0
               (tab) (tab) (tab) (tab) (tab) (tab) (tab) (tt "cell universe")
               (close-p 4) (close-p 3) (close-p 2) (close-p 1))))

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
   (hbl-append 0 (tt "(defn rule-alive"))
   (hbl-append 0 (tt "  [size]"))
   (hbl-append 0 (tt "  (match [size]"))
   (hbl-append 0 (tt "    [2] true"))
   (hbl-append 0 (tt "    [3] true))"))))

(define (exhaustive-1-clojure)
  (vl-append
   0
   (hbl-append 0 (tt "(defn rule-alive"))
   (hbl-append 0 (tt "  [size]"))
   (hbl-append 0 (tt "  (match [size]"))
   (hbl-append 0 (tt "    [2] true"))
   (hbl-append 0 (tt "    [3] true"))
   (hbl-append 0 (tt "    :else false))"))))

(define (non-exhaustive-2-clojure)
  (vl-append
   0
   (hbl-append 0 (tt "(defn rule-born"))
   (hbl-append 0 (tt "  [neighbours]"))
   (hbl-append 0 (tt "  (if (= 3 neighbours) true))"))))

(define (exhaustive-2-clojure)
  (vl-append
   0
   (hbl-append 0 (tt "(defn rule-born"))
   (hbl-append 0 (tt "  [neighbours]"))
   (hbl-append 0 (tt "  (if (= 3 neighbours) true false))"))))

(define (intermediate-variables-clojure)
  (vl-append
   0
   (hbl-append 0 (tt "(deftest is-neighbour-test"))
   (hbl-append 0 (tt "  (let [cell [2 1]"))
   (hbl-append 0 (tt "        neighbour [3 0]]"))
   (hbl-append 0 (tt "  (is (is-neighbour cell neighbour)))"))))

(define (non-intermediate-variables-clojure)
  (vl-append
   0
   (hbl-append 0 (tt "(deftest is-neighbour-test"))
   (hbl-append 0 (tt "  (is (is-neighbour [2 1] [3 0])))"))))

(define (non-intermediate-variables-alternate-clojure)
  (vl-append
   0
   (hbl-append 0 (tt "(def cell [2 1])"))
   (hbl-append 0 (tt "(def neighbour [3 0]"))
   (hbl-append 0 (tt "(deftest is-neighbour-test"))
   (hbl-append 0 (tt "  (is (is-neighbour cell neighbour)))"))))

(define (recursion-clojure)
  (vl-append
   0
   (hbl-append 0 (tt "(defn get-neighbours"))
   (hbl-append 0 (tt "[cell]"))
   (hbl-append 0 (tt "(loop [neighbour (first neighbours)"))
   (hbl-append 0 (tt "      rest-n (rest neighbours)"))
   (hbl-append 0 (tt "       result []]"))
   (hbl-append 0 (tt "  (if-not neighbour"))
   (hbl-append 0 (tt "    result"))
   (hbl-append 0 (tt "     (recur"))
   (hbl-append 0 (tt "     (first rest-n)"))
   (hbl-append 0 (tt "     (rest rest-n)"))
   (hbl-append 0 (tt "      (conj result"))
   (hbl-append 0 (tt "            (add-for-neighbour cell neighbour))))))"))))

(define (non-recursion-clojure)
  (vl-append
   0
   (hbl-append 0 (tt "(defn get-neighbours"))
   (hbl-append 0 (tt "  [cell]"))
   (hbl-append 0 (tt "  (map #(add-for-neighbour cell %) neighbours))"))))

(define (non-recursion-alternate-clojure)
  (vl-append
   0
   (hbl-append 0 (tt "(defn get-neighbours"))
   (hbl-append 0 (tt "  [cell]"))
   (hbl-append 0 (tt "  (map #(add-for-neighbour cell %) neighbours))"))))

(define (non-generic-building-block-clojure)
  (vl-append
   0
   (hbl-append 0 (tt "(defn new-cell-status"))
   (hbl-append 0 (tt "  [cell universe]"))
   (hbl-append 0 (tt "  (rule-alive"))
   (hbl-append 0 (tt "    (count (find-alive-neighbours cell universe))))"))))

(define (generic-building-block-clojure)
  (vl-append
   0
   (hbl-append 0 (tt "(defn new-cell-status"))
   (hbl-append 0 (tt "  [cell universe rule]"))
   (hbl-append 0 (tt "  (rule"))
   (hbl-append 0 (tt "    (count (find-alive-neighbours cell universe))))"))))

(define (generic-building-block-alternate-clojure)
  (vl-append
   0
   (hbl-append 0 (tt "(defn new-cell-status"))
   (hbl-append 0 (tt "  [cell universe rule]"))
   (hbl-append 0 (tt "  (-> universe"))
   (hbl-append 0 (tt "      (find-alive-neighbours cell)"))
   (hbl-append 0 (tt "      count"))
   (hbl-append 0 (tt "      rule))"))))

(define (side-effect-clojure)
  (vl-append
   0
   (hbl-append 0 (tt "(defn save-new-borns [new-borns]"))
   (hbl-append 0 (tt "  ... saving on db ..."))
   (hbl-append 0 (tt ""))
   (hbl-append 0 (tt "(defn find-new-borns"))
   (hbl-append 0 (tt "  [universe]"))
   (hbl-append 0 (tt "  ...(save-new-borns all-found) ...)"))))

(define (side-effect-injection-clojure)
  (vl-append
   0
   (hbl-append 0 (tt "(defn save-new-borns [new-borns]"))
   (hbl-append 0 (tt "  ... saving on db ..."))
   (hbl-append 0 (tt ""))
   (hbl-append 0 (tt "(defn find-new-borns"))
   (hbl-append 0 (tt "  [universe saving]"))
   (hbl-append 0 (tt "  ...(saving all-found) ...)"))))

(define (side-effect-out-clojure)
  (vl-append
   0
   (hbl-append 0 (tt "(defn save-new-borns [new-borns]"))
   (hbl-append 0 (tt "  ... saving on db ..."))
   (hbl-append 0 (tt ""))
   (hbl-append 0 (tt "(defn find-new-borns"))
   (hbl-append 0 (tt "  [universe]"))
   (hbl-append 0 (tt "  ..."))
   (hbl-append 0 (tt "  all-found)"))
   (hbl-append 0 (tt ""))
   (hbl-append 0 (tt "(defn main"))
   (hbl-append 0 (tt "  ..."))
   (hbl-append 0 (tt "  (-> universe"))
   (hbl-append 0 (tt "      find-new-borns"))
   (hbl-append 0 (tt "      save-new-borns)"))))

(define (side-effect-out-alternate-clojure)
  (vl-append
   0
   (hbl-append 0 (tt "(defn save-new-borns [new-borns]"))
   (hbl-append 0 (tt "  ... saving on db ..."))
   (hbl-append 0 (tt ""))
   (hbl-append 0 (tt "(defn find-new-borns"))
   (hbl-append 0 (tt "  [universe]"))
   (hbl-append 0 (tt "  ..."))
   (hbl-append 0 (tt "  all-found)"))
   (hbl-append 0 (tt ""))
   (hbl-append 0 (tt "(defn main"))
   (hbl-append 0 (tt "  ..."))
   (hbl-append 0 (tt "  (-> universe"))
   (hbl-append 0 (tt "      find-new-borns"))
   (hbl-append 0 (tt "      save-new-borns)"))))

(define (non-sequence-clojure)
  (vl-append
   0
   (hbl-append 0 (tt "(defn find-alive-neighbours"))
   (hbl-append 0 (tt "  [cell universe]"))
   (hbl-append 0 (tt "  (filterv #(is-neighbour cell %) universe))"))))

(define (sequence-clojure)
  (vl-append
   0
   (hbl-append 0 (tt "(defn find-alive-neighbours"))
   (hbl-append 0 (tt "  [cell universe]"))
   (hbl-append 0 (tt "  (filter #(is-neighbour cell %) universe))"))))

(define (multiple-arguments-clojure)
  (vl-append
   0
   (hbl-append 0 (tt "(defn add-for-neighbour"))
   (hbl-append 0 (tt "  [cell neighbour]"))
   (hbl-append 0 (tt "  (vector (+ (first cell) (first neighbour))"))
   (hbl-append 0 (tt "          (+ (second cell)  (second neighbour))))"))
   (hbl-append 0 (tt ""))
   (hbl-append 0 (tt "(defn get-neighbours"))
   (hbl-append 0 (tt "  [cell]"))
   (hbl-append 0 (tt "  (map #(add-for-neighbour cell %) neighbours))"))))

(define (single-argument-clojure)
  (vl-append
   0
   (hbl-append 0 (tt "(defn add-for-neighbour"))
   (hbl-append 0 (tt "  [cell neighbour]"))
   (hbl-append 0 (tt "  (vector (+ (first cell) (first neighbour))"))
   (hbl-append 0 (tt "          (+ (second cell)  (second neighbour))))"))
   (hbl-append 0 (tt ""))
   (hbl-append 0 (tt "(defn get-neighbours"))
   (hbl-append 0 (tt "  [cell]"))
   (hbl-append 0 (tt "  (let [add-for (partial add-for-neighbour cell)]"))
   (hbl-append 0 (tt "    (map #(add-for %) neighbours)))"))))

(define (multiple-arguments-2-clojure)
  (vl-append
   0
   (hbl-append 0 (tt "(defn new-cell-status"))
   (hbl-append 0 (tt "  [cell universe]"))
   (hbl-append 0 (tt "  (rule-alive"))
   (hbl-append 0 (tt "    (count (find-alive-neighbours cell universe))))"))))

(define (composition-clojure)
  (vl-append
   0
   (hbl-append 0 (tt "(def is-alive?"))
   (hbl-append 0 (tt "  (comp rule-alive count find-alive-neighbours))"))
   (hbl-append 0 (tt ""))
   (hbl-append 0 (tt "(defn new-cell-status-s"))
   (hbl-append 0 (tt "[cell universe]"))
   (hbl-append 0 (tt "(is-alive? cell universe))"))))
