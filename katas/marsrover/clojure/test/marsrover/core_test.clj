(ns marsrover.core-test
  (:require [clojure.test :refer :all]
            [marsrover.core :refer :all]))

(def world (initialize-coordinate-system "10,10,standard-coordinates"))

(deftest world-setup
  (testing "set initial size and coordinate system"
    (let [world (initialize-coordinate-system "5,6,standard-coordinates")]
      (is (= 5 (:x-limit world)))
      (is (= 6 (:y-limit world)))
      (is (= "standard-coordinates" (:directions world)))))

  (testing "Put rover in world at 0,0,N"
    (let [rover (initialize-rover)
          rover (place-rover-in-world rover world 0 0 :N)]
      (is (= 0 (:x (rover-position rover))))
      (is (= 0 (:y (rover-position rover))))
      (is (= :N (:direction (rover-position rover))))))

  (testing "Put rover in world at 1,2,E"
    (let [rover (initialize-rover)
          rover (place-rover-in-world rover world 1 2 :E)]
      (is (= 1 (:x (rover-position rover))))
      (is (= 2 (:y (rover-position rover))))
      (is (= :E (:direction (rover-position rover)))))))

(deftest mars-rover-rotating
  (testing "turn right"
    (let [rover (initialize-rover)
          rover (place-rover-in-world rover world 0 0 :N)]
      (is (= :E (:direction (rover-position (turn rover "R")))))
      (is (= :S (:direction (rover-position (turn rover "RR")))))
      (is (= :W (:direction (rover-position (turn rover "RRR")))))
      (is (= :N (:direction (rover-position (turn rover "RRRR")))))))
  
  (testing "turn left"
    (let [rover (initialize-rover "0,0,N")
          rover (place-rover-in-world rover world 0 0 :N)]
      (is (= :W (:direction (rover-position (turn rover "L")))))
      (is (= :S (:direction (rover-position (turn rover "LL")))))
      (is (= :E (:direction (rover-position (turn rover "LLL")))))
      (is (= :N (:direction (rover-position (turn rover "LLLL"))))))))

(deftest mars-moving
  (testing "move forwards North"
    (let [rover (initialize-rover "0,0,N")]
      (is (= 1 (:x (move "F" rover))))
      (is (= 2 (:x (move "FF" rover))))
      (is (= 3 (:x (move "FFF" rover))))))

  (testing "move backwards North"
    (let [rover (initialize-rover "3,0,N")]
      (is (= 2 (:x (move "B" rover))))
      (is (= 1 (:x (move "BB" rover))))
      (is (= 0 (:x (move "BBB" rover))))))

  (testing "move forwards South"
    (let [rover (initialize-rover "3,0,S")]
      (is (= 2 (:x (move "F" rover))))
      (is (= 1 (:x (move "FF" rover))))
      (is (= 0 (:x (move "FFF" rover))))))

  (testing "move backwards South"
    (let [rover (initialize-rover "0,0,S")]
      (is (= 1 (:x (move "B" rover))))
      (is (= 2 (:x (move "BB" rover))))
      (is (= 3 (:x (move "BBB" rover))))))

  (testing "move forwards East"
    (let [rover (initialize-rover "0,0,E")]
      (is (= 1 (:y (move "F" rover))))
      (is (= 2 (:y (move "FF" rover))))
      (is (= 3 (:y (move "FFF" rover))))))

  (testing "move backwards East"
    (let [rover (initialize-rover "0,3,E")]
      (is (= 2 (:y (move "B" rover))))
      (is (= 1 (:y (move "BB" rover))))
      (is (= 0 (:y (move "BBB" rover))))))

  (testing "move forwards West"
    (let [rover (initialize-rover "0,3,W")]
      (is (= 2 (:y (move "F" rover))))
      (is (= 1 (:y (move "FF" rover))))
      (is (= 0 (:y (move "FFF" rover))))))

  (testing "move backwards West"
    (let [rover (initialize-rover "0,0,W")]
      (is (= 1 (:y (move "B" rover))))
      (is (= 2 (:y (move "BB" rover))))
      (is (= 3 (:y (move "BBB" rover)))))))
