(ns marsrover.core-test
  (:require [clojure.test :refer :all]
            [marsrover.core :refer :all]))

(defmacro test-helper
  [actual expected operation]
  (list 'is (list operation expected actual)))

(def world (initialize-coordinate-system "10,10,standard-coordinates"))

(defn get-rover [x y direction]
  (-> (initialize-rover)
      (place-rover-in-world world x y direction)))

(deftest world-setup
  (testing "set initial size and coordinate system"
    (let [world (initialize-coordinate-system "5,6,standard-coordinates")]
      (is (= 5 (:x-limit world)))
      (is (= 6 (:y-limit world)))
      (is (= standard-coordinates @(:directions world))))))

(deftest rover-in-world
  (testing "Put rover in world at 0,0,N"
    (is (= 0 (:x (rover-position (get-rover 0 0 :N)))))
    (is (= 0 (:y (rover-position (get-rover 0 0 :N)))))
    (is (= :N (:direction (rover-position (get-rover 0 0 :N))))))

  (testing "Put rover in world at 1,2,E"
    (is (= 1 (:x (rover-position (get-rover 1 2 :E)))))
    (is (= 2 (:y (rover-position (get-rover 1 2 :E)))))
    (is (= :E (:direction (rover-position (get-rover 1 2 :E)))))))

(defn test-turn [x y direction movement expected]
  (-> (get-rover x y direction)
      (turn movement)
      (rover-position)
      (:direction)
      (test-helper expected =)))

(deftest mars-rover-rotating
  (testing "turn right"
    (test-turn 0 0 :N "R" :E)
    (test-turn 0 0 :N "RR" :S)
    (test-turn 0 0 :N "RRR" :W)
    (test-turn 0 0 :N "RRRR" :N))
  
  (testing "turn left"
    (test-turn 0 0 :N "L" :W)
    (test-turn 0 0 :N "LL" :S)
    (test-turn 0 0 :N "LLL" :E)
    (test-turn 0 0 :N "LLLL" :N)))

(defn extract-value [rover-in-world]
  ((:axis ((:direction rover-in-world) (:movement @(:directions (:world rover-in-world))))) rover-in-world))

(defn test-move [x y direction movement expected]
  (-> (get-rover x y direction)
      (move movement)
      (rover-position)
      (extract-value)
      (test-helper expected =)))

(deftest mars-moving
  (testing "move forwards North"
    (test-move 0 0 :N "F" 1)
    (test-move 0 0 :N "FF" 2)
    (test-move 0 0 :N "FFF" 3))

  (testing "move backwards North"
    (test-move 3 0 :N "B" 2)
    (test-move 3 0 :N "BB" 1)
    (test-move 3 0 :N "BBB" 0))

  (testing "move forwards South"
    (test-move 3 0 :S "F" 2)
    (test-move 3 0 :S "FF" 1)
    (test-move 3 0 :S "FFF" 0))

  (testing "move backwards South"
    (test-move 0 0 :S "B" 1)
    (test-move 0 0 :S "BB" 2)
    (test-move 0 0 :S "BBB" 3))

  (testing "move forwards East"
    (test-move 0 0 :E "F" 1)
    (test-move 0 0 :E "FF" 2)
    (test-move 0 0 :E "FFF" 3))

  (testing "move backwards East"
    (test-move 0 3 :E "B" 2)
    (test-move 0 3 :E "BB" 1)
    (test-move 0 3 :E "BBB" 0))

  (testing "move forwards West"
    (test-move 0 3 :W "F" 2)
    (test-move 0 3 :W "FF" 1)
    (test-move 0 3 :W "FFF" 0))

  (testing "move backwards West"
    (test-move 0 0 :W "B" 1)
    (test-move 0 0 :W "BB" 2)
    (test-move 0 0 :W "BBB" 3)))

(deftest mars-move-wrapping
  (testing "wrap North"
    (test-move 10 0 :N "F" 0)
    (test-move 10 0 :N "FF" 1)
    (test-move 9 0 :N "FFFF" 2))

  (testing "wrap South"
    (test-move 0 0 :S "F" 10)
    (test-move 0 0 :S "FF" 9)
    (test-move 1 0 :S "FFFF" 8))

  (testing "wrap East"
    (test-move 0 10 :E "F" 0)
    (test-move 0 10 :E "FF" 1)
    (test-move 0 9 :E "FFFF" 2))

  (testing "wrap West"
    (test-move 0 0 :W "F" 10)
    (test-move 0 0 :W "FF" 9)
    (test-move 0 1 :W "FFFF" 8)))
