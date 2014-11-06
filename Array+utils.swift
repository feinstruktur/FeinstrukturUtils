//
//  Array+utils.swift
//  swift-utils
//
//  Created by Sven Schmidt on 05/11/2014.
//
//

import Foundation


// Fisher-Yates (aka Knuth) Shuffle
func shuffle<T>(var array: Array<T>) -> Array<T> {
    var m = array.count
    var t: T
    var i: Int
    while m > 0 {
        i = Int(arc4random() % UInt32(m))
        --m
        t = array[m]
        array[m] = array[i]
        array[i] = t
    }
    return array
}


extension Array {

    func shuffled() -> Array {
        return shuffle(self)
    }
    
    mutating func remove<U: Equatable>(itemToRemove: U) {
        let lastIndex = self.count - 1
        for (index, item) in enumerate(self.reverse()) {
            if item as U == itemToRemove {
                let indexFromStart = lastIndex - index
                self.removeAtIndex(indexFromStart)
            }
        }
    }
}
