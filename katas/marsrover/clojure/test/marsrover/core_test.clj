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
      (is (= :S (:direction (turn "RR" rover))))))
  
  (testing "turn left"))
