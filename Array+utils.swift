//
//  Array+utils.swift
//  swift-utils
//
//  Created by Sven Schmidt on 05/11/2014.
//
//

import Foundation


func random(max: UInt32) -> UInt32 {
    return arc4random_uniform(max + 1)
}


// Fisher-Yates (aka Knuth) Shuffle
func shuffle<T>(var array: Array<T>) -> Array<T> {
    for var i = array.count - 1; i > 0; i-- {
        let j = Int(random(UInt32(i)))
        swap(&array[j], &array[i])
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
