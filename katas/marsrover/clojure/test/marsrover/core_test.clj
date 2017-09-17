(ns marsrover.core-test
  (:require [clojure.test :refer :all]
            [marsrover.core :refer :all]))

(deftest mars-rover-setup
  (testing "set position of the mars rover to 0,0,N"
    (let [rover  (initialize-rover "0,0,N")]
      (is (= 0 (:x rover)))
      (is (= 0 (:y rover)))
      (is (= :N (:direction rover))))))
