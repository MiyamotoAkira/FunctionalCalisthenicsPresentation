(ns marsrover.core
  (:require [clojure.string :as str]) )

(def directions {"N" :N "E" :E "S" :S "W" :W})

(def directions-literals #{"N" "E" "S" "W"})

(defn parse-input-element [input]
  (println input)
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
