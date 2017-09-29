(ns marsrover.core-test
  (:require [clojure.test :refer :all]
            [marsrover.core :refer :all]))

(defn test-helper [actual expected operation]
  (is (operation expected actual)))

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
    (is (= :W (:direction (rover-position (turn (get-rover 0 0 :N) "L")))))
    (is (= :S (:direction (rover-position (turn (get-rover 0 0 :N) "LL")))))
    (is (= :E (:direction (rover-position (turn (get-rover 0 0 :N) "LLL")))))
    (is (= :N (:direction (rover-position (turn (get-rover 0 0 :N) "LLLL")))))))

(defn test-move [x y direction movement expected]
  (-> (get-rover x y direction)
      (move movement)
      (:x)
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
    (is (= 2 (:x (move (get-rover 3 0 :S) "F"))))
    (is (= 1 (:x (move (get-rover 3 0 :S) "FF"))))
    (is (= 0 (:x (move (get-rover 3 0 :S) "FFF")))))

  (testing "move backwards South"
    (is (= 1 (:x (move (get-rover 0 0 :S) "B"))))
    (is (= 2 (:x (move (get-rover 0 0 :S) "BB"))))
    (is (= 3 (:x (move (get-rover 0 0 :S) "BBB")))))

  (testing "move forwards East"
    (is (= 1 (:y (move (get-rover 0 0 :E) "F"))))
    (is (= 2 (:y (move (get-rover 0 0 :E) "FF"))))
    (is (= 3 (:y (move (get-rover 0 0 :E) "FFF")))))

  (testing "move backwards East"
    (is (= 2 (:y (move (get-rover 0 3 :E) "B"))))
    (is (= 1 (:y (move (get-rover 0 3 :E) "BB"))))
    (is (= 0 (:y (move (get-rover 0 3 :E) "BBB")))))

  (testing "move forwards West"
    (is (= 2 (:y (move (get-rover 0 3 :W) "F"))))
    (is (= 1 (:y (move (get-rover 0 3 :W) "FF"))))
    (is (= 0 (:y (move (get-rover 0 3 :W) "FFF")))))

  (testing "move backwards West"
    (is (= 1 (:y (move (get-rover 0 0 :W) "B"))))
    (is (= 2 (:y (move (get-rover 0 0 :W) "BB"))))
    (is (= 3 (:y (move (get-rover 0 0 :W) "BBB"))))))
