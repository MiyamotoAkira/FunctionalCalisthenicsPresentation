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

(define (declarations-clojure)
  (vl-append
   (tt "(def neighbours ")
   (tt "  [[-1 -1] [-1 0] [-1 1] [0 -1]")
   (tt "   [0 1] [1 -1] [1 0] [1 1]])")))

(define (bad-naming-clojure)
  (vl-append
   0
   (tt "(defn new-cell-status")
   (tt "  [cell universe]")
   (tt "  (let [size (count")
   (tt "               (find-alive-neighbours")
   (tt "                 cell universe))]")
   (tt "  (or (= 2 size) (= 3 size)))) ")))

(define (good-naming-clojure)
  (vl-append
   0
   (tt "(defn rule-alive")
   (tt "  [size]")
   (tt"   (or (= 2 size) (= 3 size)))")
   (tt "")
   (tt "(defn new-cell-status")
   (tt "  [cell universe]")
   (tt "  (rule-alive")
   (tt "     (count (find-alive-neighbours")
   (tt "              cell universe))))")))

(define (statement-clojure)
  (vl-append
   0
   (tt "(let [result (some-calculation some-parameter)]")
   (tt " (another-call result))")))

(define (expression-clojure)
  (vl-append
   0
   (tt "(another-call (some-calculation some-parameter))")))

(define (mutable-state-clojure)
  (tt "(def universe (atom [[1 0] [0 0] [-1 0])"))

(define (non-mutable-state-clojure)
  (tt "(def universe [[1 0] [0 0] [-1 0]]"))

(define (non-exhaustive-1-clojure)
  (vl-append
   0
   (tt "(defn rule-alive")
   (tt "  [size]")
   (tt "  (match [size]")
   (tt "    [2] true")
   (tt "    [3] true))")))

(define (exhaustive-1-clojure)
  (vl-append
   0
   (tt "(defn rule-alive")
   (tt "  [size]")
   (tt "  (match [size]")
   (tt "    [2] true")
   (tt "    [3] true")
   (tt "    :else false))")))

(define (non-exhaustive-2-clojure)
  (vl-append
   0
   (tt "(defn rule-born")
   (tt "  [neighbours]")
   (tt "  (if (= 3 neighbours) true))")))

(define (exhaustive-2-clojure)
  (vl-append
   0
   (tt "(defn rule-born")
   (tt "  [neighbours]")
   (tt "  (if (= 3 neighbours) true false))")))

(define (intermediate-variables-clojure)
  (vl-append
   0
   (tt "(deftest is-neighbour-test")
   (tt "  (let [cell [2 1]")
   (tt "        neighbour [3 0]]")
   (tt "  (is (is-neighbour cell neighbour)))")))

(define (non-intermediate-variables-clojure)
  (vl-append
   0
   (tt "(deftest is-neighbour-test")
   (tt "  (is (is-neighbour [2 1] [3 0])))")))

(define (non-intermediate-variables-alternate-clojure)
  (vl-append
   0
   (tt "(def cell [2 1])")
   (tt "(def neighbour [3 0]")
   (tt "(deftest is-neighbour-test")
   (tt "  (is (is-neighbour cell neighbour)))")))

(define (recursion-clojure)
  (vl-append
   0
   (tt "(defn get-neighbours")
   (tt "[cell]")
   (tt "(loop [neighbour (first neighbours)")
   (tt "      rest-n (rest neighbours)")
   (tt "       result []]")
   (tt "  (if-not neighbour")
   (tt "    result")
   (tt "     (recur")
   (tt "     (first rest-n)")
   (tt "     (rest rest-n)")
   (tt "      (conj result")
   (tt "            (add-for-neighbour cell neighbour))))))")))

(define (non-recursion-clojure)
  (vl-append
   0
   (tt "(defn get-neighbours")
   (tt "  [cell]")
   (tt "  (map #(add-for-neighbour cell %) neighbours))")))

(define (non-recursion-alternate-clojure)
  (vl-append
   0
   (tt "(defn get-neighbours")
   (tt "  [cell]")
   (tt "  (map #(add-for-neighbour cell %) neighbours))")))

(define (non-generic-building-block-clojure)
  (vl-append
   0
   (tt "(defn new-cell-status")
   (tt "  [cell universe]")
   (tt "  (rule-alive")
   (tt "    (count (find-alive-neighbours cell universe))))")))

(define (generic-building-block-clojure)
  (vl-append
   0
   (tt "(defn new-cell-status")
   (tt "  [cell universe rule]")
   (tt "  (rule")
   (tt "    (count (find-alive-neighbours cell universe))))")))

(define (generic-building-block-alternate-clojure)
  (vl-append
   0
   (tt "(defn new-cell-status")
   (tt "  [cell universe rule]")
   (tt "  (-> universe")
   (tt "      (find-alive-neighbours cell)")
   (tt "      count")
   (tt "      rule))")))

(define (side-effect-clojure)
  (vl-append
   0
   (tt "(defn save-new-borns [new-borns]")
   (tt "  ... saving on db ...")
   (tt "")
   (tt "(defn find-new-borns")
   (tt "  [universe]")
   (tt "  ...(save-new-borns all-found) ...)")))

(define (side-effect-injection-clojure)
  (vl-append
   0
   (tt "(defn save-new-borns [new-borns]")
   (tt "  ... saving on db ...")
   (tt "")
   (tt "(defn find-new-borns")
   (tt "  [universe saving]")
   (tt "  ...(saving all-found) ...)")))

(define (side-effect-out-clojure)
  (vl-append
   0
   (tt "(defn save-new-borns [new-borns]")
   (tt "  ... saving on db ...")
   (tt "")
   (tt "(defn find-new-borns")
   (tt "  [universe]")
   (tt "  ...")
   (tt "  all-found)")
   (tt "")
   (tt "(defn main")
   (tt "  ...")
   (tt "  (-> universe")
   (tt "      find-new-borns")
   (tt "      save-new-borns)")))

(define (side-effect-out-alternate-clojure)
  (vl-append
   0
   (tt "(defn save-new-borns [new-borns]")
   (tt "  ... saving on db ...")
   (tt "")
   (tt "(defn find-new-borns")
   (tt "  [universe]")
   (tt "  ...")
   (tt "  all-found)")
   (tt "")
   (tt "(defn main")
   (tt "  ...")
   (tt "  (-> universe")
   (tt "      find-new-borns")
   (tt "      save-new-borns)")))

(define (non-sequence-clojure)
  (vl-append
   0
   (tt "(defn find-alive-neighbours")
   (tt "  [cell universe]")
   (tt "  (filterv #(is-neighbour cell %) universe))")))

(define (sequence-clojure)
  (vl-append
   0
   (tt "(defn find-alive-neighbours")
   (tt "  [cell universe]")
   (tt "  (filter #(is-neighbour cell %) universe))")))

(define (multiple-arguments-clojure)
  (vl-append
   0
   (tt "(defn add-for-neighbour")
   (tt "  [cell neighbour]")
   (tt "  (vector (+ (first cell) (first neighbour))")
   (tt "          (+ (second cell)  (second neighbour))))")
   (tt "")
   (tt "(defn get-neighbours")
   (tt "  [cell]")
   (tt "  (map #(add-for-neighbour cell %) neighbours))")))

(define (single-argument-clojure)
  (vl-append
   0
   (tt "(defn add-for-neighbour")
   (tt "  [cell neighbour]")
   (tt "  (vector (+ (first cell) (first neighbour))")
   (tt "          (+ (second cell)  (second neighbour))))")
   (tt "")
   (tt "(defn get-neighbours")
   (tt "  [cell]")
   (tt "  (let [add-for (partial add-for-neighbour cell)]")
   (tt "    (map #(add-for %) neighbours)))")))

(define (multiple-arguments-2-clojure)
  (vl-append
   0
   (tt "(defn new-cell-status")
   (tt "  [cell universe]")
   (tt "  (rule-alive")
   (tt "    (count (find-alive-neighbours cell universe))))")))

(define (composition-clojure)
  (vl-append
   0
   (tt "(def is-alive?")
   (tt "  (comp rule-alive count find-alive-neighbours))")
   (tt "")
   (tt "(defn new-cell-status-s")
   (tt "[cell universe]")
   (tt "(is-alive? cell universe))")))
