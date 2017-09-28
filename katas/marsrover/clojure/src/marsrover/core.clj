(ns marsrover.core
  (:require [clojure.string :as str]) )

(def directions-parsing {"N" :N "E" :E "S" :S "W" :W})

(def directions-literals #{"N" "E" "S" "W"})

(def next-turn-right {:N :E :E :S :S :W :W :N})

(def next-turn-left {:N :W :W :S :S :E :E :N})

(def standard-coordinates
  {:directions-parsing directions-parsing
   :directions-literals directions-literals
   :turn-right next-turn-right
   :turn-left next-turn-left})

(defn parse-input-element [input]
  (cond
    (nil? (directions-literals input)) (Integer/parseInt input)
    :else (directions-parsing input)))

(defn zip-rover [data]
  (zipmap [:x :y :direction] data))

(defn parse-input [input]
  (map #(parse-input-element %) input))

(defn initialize-rover
  ([]
   "Initializes a rover for use on a world"
   {:speed 1}))

(defn parse-coordinate-element [input]
  (cond
    (re-find #"[^0-9]" input) (resolve (symbol input))
    :else (Integer/parseInt input)))

(defn parse-coordinate-system-input [input]
  (map #(parse-coordinate-element %) input))

(defn zip-coordinate-system [data]
  (zipmap [:x-limit :y-limit :directions] data))

(defn initialize-coordinate-system
  [initialization]
  "Creates a new coordinate system with limits and directions.
The coordinate system has to be a 2D environment."
  (-> initialization
      (str/split #",")
      (parse-coordinate-system-input)
      (zip-coordinate-system)))

(defn turn-right [rover]
  (assoc rover :direction ((:direction rover) next-turn-right)))

(defn turn-left [rover]
  (assoc rover :direction ((:direction rover) next-turn-left)))

(defn select-turn [turn]
  (condp = turn
    \R turn-right
    \L turn-left))

(defn turn [rover turns]
  (assoc rover :rover-in-world (reduce #((select-turn %2) %1) (:rover-in-world rover) turns)))

(defn move-forwards [speed rover-in-world]
  (condp = (:direction rover-in-world)
    :N (assoc rover-in-world :x (+ (:x rover-in-world) speed))
    :S (assoc rover-in-world :x (- (:x rover-in-world) speed))
    :E (assoc rover-in-world :y (+ (:y rover-in-world) speed))
    :W (assoc rover-in-world :y (- (:y rover-in-world) speed))))

(defn move-backwards [speed rover-in-world]
  (condp = (:direction rover-in-world)
    :N (assoc rover-in-world :x (- (:x rover-in-world) speed))
    :S (assoc rover-in-world :x (+ (:x rover-in-world) speed))
    :E (assoc rover-in-world :y (- (:y rover-in-world) speed))
    :W (assoc rover-in-world :y (+ (:y rover-in-world) speed))))

(defn select-movement [movement]
  (condp = movement
    \F move-forwards
    \B move-backwards))

(defn wrap-NS-movement [rover]
  (if (> (:x rover) (:grid-x-size rover))
    (assoc rover :x (- (:x rover) (:grid-x-size rover) 1))
    rover))

(defn wrap-movement [rover]
  (-> rover
      (wrap-NS-movement)))

(defn move [rover movement]
  (reduce #((select-movement %2) (:speed rover) %1) (:rover-in-world rover) movement))

(defn place-rover-in-world [rover world x y direction]
  (assoc rover :rover-in-world {:world world :x x :y y :direction direction}))

(defn rover-position [rover]
  (:rover-in-world rover))
