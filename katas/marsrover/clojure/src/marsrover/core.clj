(ns marsrover.core
  (:require [clojure.string :as str]) )

(def directions {"N" :N "E" :E "S" :S "W" :W})

(def directions-literals #{"N" "E" "S" "W"})

(defn parse-input-element [input]
  (cond
    (nil? (directions-literals input)) (Integer/parseInt input)
    :else (directions input)))

(defn zip-rover [data]
  (zipmap [:x :y :direction] data))

(defn parse-input [input]
  (map #(parse-input-element  %) input))

(defn initialize-rover
  "Initializes a rover map"
  [initialization]

  (-> initialization
      (str/split #",")
      (parse-input)
      (zip-rover)))

(defn turn-right [rover]
  (condp = (:direction rover)
    :N (assoc rover :direction :E)
    :E (assoc rover :direction :S)
    :S (assoc rover :direction :W)
    :W (assoc rover :direction :N)))

(defn turn-left [rover]
  (condp = (:direction rover)
    :N (assoc rover :direction :W)
    :W (assoc rover :direction :S)
    :S (assoc rover :direction :E)
    :E (assoc rover :direction :N)))

(defn select-turn [turn]
  (condp = turn
    \R turn-right
    \L turn-left))

(defn turn [turns rover]
  (reduce #((select-turn %2) %1) rover turns))
