//
//  Random.swift
//  swift-utils
//
//  Created by Sven Schmidt on 13/12/2014.
//
//

import Foundation


public func random(max: Int) -> Int {
    return Int(random(UInt32(max)))
}


public func random(max: UInt32) -> UInt32 {
    return arc4random_uniform(max + 1)
}


public func random() -> Double {
    return Double(random(UINT32_MAX-1)) / Double(UINT32_MAX-1)
}


// Uniform randum number from [a, b[, where b >= a
public func random(from: Double, to: Double) -> Double {
    assert(to >= from, "upper bound must be greater than or equal to lower bound")
    return from + (to-from) * random()
}


// Fisher-Yates (aka Knuth) Shuffle
public func shuffle<T>(var array: Array<T>) -> Array<T> {
    for var i = array.count - 1; i > 0; i-- {
        let j = Int(random(i))
        swap(&array[j], &array[i])
    }
    return array
}


func createHitmap(weights: [Double]) -> [Double] {
    if weights.count > 1 {
        let s = sum(weights)
        assert(s >= 0, "sum of weights must be greater than zero")
        var result = [weights[0]/s]
        for index in 1..<weights.count-1 {
            result.append(weights[index]/s + result[index-1])
        }
        return result
    } else {
        return []
    }
}


func findBucket(hitmap: [Double], value: Double) -> Int {
    var index = 0
    while index < hitmap.count && value > hitmap[index] {
        index++
    }
    return index
}


// If weights.count < array.count the last element of weights will be repeated to match the size of the array
// If weights is empty it will be filled with 1.0
// If weights.count > array.count it will be trimmed to array.count
// Don't use weights that sum to less than or equal to zero
public func randomElement<T>(array: [T], var weights: [Double] = [1.0]) -> T? {
    if array.count > 0 {
        if weights == [] {
            weights = [1.0]
        }
        while weights.count < array.count {
            weights.append(weights.last ?? 1.0)
        }
        if weights.count > array.count {
            weights = Array(weights[0..<array.count])
        }
        assert(array.count == weights.count, "array size must equal weights size")
        let index = findBucket(createHitmap(weights), random())
        return array[index]
    } else {
        return nil
    }
}
