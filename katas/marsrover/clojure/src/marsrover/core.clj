(ns marsrover.core
  (:require [clojure.string :as str]) )

(def directions {"N" :N "E" :E "S" :S "W" :W})

(def directions-literals #{"N" "E" "S" "W"})

(def next-turn-right {:N :E :E :S :S :W :W :N})

(def next-turn-left {:N :W :W :S :S :E :E :N})

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
  (assoc rover :direction ((:direction rover) next-turn-right)))

(defn turn-left [rover]
  (assoc rover :direction ((:direction rover) next-turn-left)))

(defn select-turn [turn]
  (condp = turn
    \R turn-right
    \L turn-left))

(defn turn [turns rover]
  (reduce #((select-turn %2) %1) rover turns))
