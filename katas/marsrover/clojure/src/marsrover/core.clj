(ns marsrover.core
  (:require [clojure.string :as str]) )

(def directions-parsing {"N" :N "E" :E "S" :S "W" :W})

(def directions-literals #{"N" "E" "S" "W"})

(def next-turn-right {:N :E :E :S :S :W :W :N})

(def next-turn-left {:N :W :W :S :S :E :E :N})

(def in-world-movement
  {:N {:axis :x :forward + :backward -}
   :S {:axis :x :forward - :backward +}
   :E {:axis :y :forward + :backward -}
   :W {:axis :y :forward - :backward +}})

(def standard-coordinates
  {:directions-parsing directions-parsing
   :directions-literals directions-literals
   :turn-right next-turn-right
   :turn-left next-turn-left
   :movement in-world-movement})

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

(defn add-obstacles [world obstacles]
  (assoc world :obstacles obstacles))

(defn check-obstacle [world position]
  (some #(and (= (first %1) (first position)) (= (second %1) (second position))) (:obstacles world)))

(defn parse-coordinate-element [input]
  (cond
    (re-find #"[^0-9]" input) (resolve (symbol "marsrover.core" input))
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

(defn turn-right-options [rover-in-world]
  (:turn-right @(:directions (:world rover-in-world))))

(defn turn-left-options [rover-in-world]
  (:turn-left @(:directions (:world rover-in-world))))

(defn direction-on-right [rover-in-world]
  ((:direction rover-in-world) (turn-right-options rover-in-world)))

(defn direction-on-left [rover-in-world]
  ((:direction rover-in-world) (turn-left-options rover-in-world)))

(defn turn-right [rover-in-world]
  (assoc rover-in-world :direction (direction-on-right rover-in-world)))

(defn turn-left [rover-in-world]
  (assoc rover-in-world :direction (direction-on-left rover-in-world)))

(defn select-turn [turn]
  (condp = turn
    \R turn-right
    \L turn-left))

(defn turn [rover turns]
  (assoc rover :rover-in-world (reduce #((select-turn %2) %1) (:rover-in-world rover) turns)))

(defn move-rover-in-world [rover-in-world axis operation speed]
  (assoc rover-in-world axis (operation (axis rover-in-world) speed)))

(defn select-operation [movement]
  (condp = movement
    \F :forward
    \B :backward))

(defn wrap-NS-movement [rover]
  (if (> (:x (:rover-in-world rover)) (:x-limit (:world (:rover-in-world rover))))
    (assoc-in rover [:rover-in-world :x] (- (:x (:rover-in-world rover)) (:x-limit (:world (:rover-in-world rover))) 1))
    rover))

(defn wrap-SN-movement [rover]
  (if (< (:x (:rover-in-world rover)) 0)
    (assoc-in rover [:rover-in-world :x] (+ (:x (:rover-in-world rover)) (:x-limit (:world (:rover-in-world rover))) 1))
    rover))

(defn wrap-EW-movement [rover]
  (if (> (:y (:rover-in-world rover)) (:y-limit (:world (:rover-in-world rover))))
    (assoc-in rover [:rover-in-world :y] (- (:y (:rover-in-world rover)) (:y-limit (:world (:rover-in-world rover))) 1))
    rover))

(defn wrap-WE-movement [rover]
  (if (< (:y (:rover-in-world rover)) 0)
    (assoc-in rover [:rover-in-world :y] (+ (:y (:rover-in-world rover)) (:y-limit (:world (:rover-in-world rover))) 1))
    rover))

(defn wrap-movement [rover]
  (condp = (:direction (:rover-in-world rover))
    :N (wrap-NS-movement rover)
    :S (wrap-SN-movement rover)
    :E (wrap-EW-movement rover)
    :W (wrap-WE-movement rover)))

(defn get-coordinate-map [world]
  @(:directions world))

(defn move-options-current-direction [rover-in-world]
  ((:direction rover-in-world)
   (-> rover-in-world
       (:world)
       (get-coordinate-map)
       (:movement))))

(defn calculate-new-position [rover-in-world movement speed]
  (move-rover-in-world
   rover-in-world
   (:axis (move-options-current-direction rover-in-world))
   ((select-operation movement) (move-options-current-direction rover-in-world))
   speed))

(defn select-position [new previous]
  (cond
    (check-obstacle (:world new) [(:x new) (:y new)]) previous
    :else new))

(defn move [rover movement]
  (wrap-movement
   (assoc rover :rover-in-world (reduce
                                 #(select-position (calculate-new-position %1 %2 (:speed rover)) %1)
                                 (:rover-in-world rover)
                                 movement))))

(defn place-rover-in-world [rover world x y direction]
  (assoc rover :rover-in-world {:world world :x x :y y :direction direction}))

(defn rover-position [rover]
  (:rover-in-world rover))
