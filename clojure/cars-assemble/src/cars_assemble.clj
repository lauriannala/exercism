(ns cars-assemble)

(def unit 221)

(defn production-rate
  "Returns the assembly line's production rate per hour,
   taking into account its success rate"
  [speed]
  (cond
    (< speed 5) (* unit (* speed 1.0))
    (< speed 9) (* unit (* speed 0.9))
    (= speed 9) (* unit (* speed 0.8))
    (= speed 10) (* unit (* speed 0.77))
    :else :invalid_speed))

(defn working-items
  "Calculates how many working cars are produced per minute"
  [speed]
  (int (/ (production-rate speed) 60)))
