//
//  Array+utils.swift
//  swift-utils
//
//  Created by Sven Schmidt on 05/11/2014.
//
//

import Foundation


func random(max: Int) -> Int {
    return Int(random(UInt32(max)))
}

func random(max: UInt32) -> UInt32 {
    return arc4random_uniform(max + 1)
}


// Fisher-Yates (aka Knuth) Shuffle
func shuffle<T>(var array: Array<T>) -> Array<T> {
    for var i = array.count - 1; i > 0; i-- {
        let j = Int(random(i))
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
    
    func each(block: (Element) -> ()) {
        for item in self {
            block(item)
        }
    }
    
    func each(block: (Int, Element) -> ()) {
        for (index, item) in enumerate(self) {
            block(index, item)
        }
    }

    func indexes<T: Equatable>(item: T) -> [Int] {
        var results = [Int]()
        self.each { (index, element) in
            if element as? T == item {
                results.append(index)
            }
        }
        return results
    }
    
    func indexOf<T: Equatable>(item: T) -> Int? {
        for (index, element) in enumerate(self) {
            if element as? T == item {
                return index
            }
        }
        return nil
    }
    
    func contains<T: Equatable>(items: T...) -> Bool {
        return items.reduce(true) { (i, j) in i && (self.indexOf(j) != nil) }
    }
    
    func first(filter: (Element) -> Bool) -> Element? {
        for item in self {
            if filter(item) {
                return item
            }
        }
        return nil
    }

}
