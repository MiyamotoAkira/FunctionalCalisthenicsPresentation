(ns marsrover.core-test
  (:require [clojure.test :refer :all]
            [marsrover.core :refer :all]))

(deftest mars-rover-setup
  (testing "set position of the mars rover to 0,0,N"
    (let [rover  (initialize-rover "0,0,N")]
      (is (= 0 (:x rover)))
      (is (= 0 (:y rover)))
      (is (= :N (:direction rover)))))

  (testing "set position of the mars rover to 1,2,E"
    (let [rover  (initialize-rover "1,2,E")]
      (is (= 1 (:x rover)))
      (is (= 2 (:y rover)))
      (is (= :E (:direction rover))))))

(deftest mars-rover-rotating
  (testing "turn right"
    (let [rover (initialize-rover "0,0,N")]
      (is (= :E (:direction (turn "R" rover))))
      (is (= :S (:direction (turn "RR" rover))))
      (is (= :W (:direction (turn "RRR" rover))))
      (is (= :N (:direction (turn "RRRR" rover))))))
  
  (testing "turn left"
    (let [rover (initialize-rover "0,0,N")]
      (is (= :W (:direction (turn "L" rover))))
      (is (= :S (:direction (turn "LL" rover))))
      (is (= :E (:direction (turn "LLL" rover))))
      (is (= :N (:direction (turn "LLLL" rover)))))))

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
      (is (= 3 (:y (move "BBB" rover))))))

  (testing "Move wrapping North movement on grid limit"
    (let [rover (initialize-rover "10,0,N,10,10")]
      (is (= 0 (:x (move "F" rover)))))))
