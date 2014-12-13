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


// Fisher-Yates (aka Knuth) Shuffle
public func shuffle<T>(var array: Array<T>) -> Array<T> {
    for var i = array.count - 1; i > 0; i-- {
        let j = Int(random(i))
        swap(&array[j], &array[i])
    }
    return array
}


