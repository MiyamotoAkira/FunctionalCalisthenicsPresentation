(ns marsrover.core
  (:require [clojure.string :as str]) )

(def directions-parsing {"N" :N "E" :E "S" :S "W" :W})

(def directions-literals #{"N" "E" "S" "W"})

(def next-turn-right {:N :E :E :S :S :W :W :N})

(def next-turn-left {:N :W :W :S :S :E :E :N})

(def standard-coordinates
  {:directons-parsing directions-parsing
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
   {})

  ([initialization]
   "Initializes an independent rover map"
   (-> initialization
       (str/split #",")
       (parse-input)
       (zip-rover))))

(defn parse-coordinate-element [input]
  (cond
    (re-find #"[^0-9]" input) input
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

(defn turn [turns rover]
  (reduce #((select-turn %2) %1) rover turns))

(defn move-forwards [rover]
  (condp = (:direction rover)
    :N (assoc rover :x (+ (:x rover) 1))
    :S (assoc rover :x (- (:x rover) 1))
    :E (assoc rover :y (+ (:y rover) 1))
    :W (assoc rover :y (- (:y rover) 1))))

(defn move-backwards [rover]
  (condp = (:direction rover)
    :N (assoc rover :x (- (:x rover) 1))
    :S (assoc rover :x (+ (:x rover) 1))
    :E (assoc rover :y (- (:y rover) 1))
    :W (assoc rover :y (+ (:y rover) 1))))

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

(defn move [movement rover]
  (reduce #((select-movement %2) %1) rover movement))

(defn place-rover-in-world [world rover x y direction]
  (assoc world :rover-in-world {:rover rover :x x :y y :direction direction}))

(defn rover-position [world]
  (:rover-in-world world))
