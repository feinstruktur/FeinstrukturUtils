//
//  Array+utils.swift
//  swift-utils
//
//  Created by Sven Schmidt on 05/11/2014.
//
//

import Foundation


public func - <T: Equatable>(first: Array<T>, second: Array<T>) -> Array<T> {
    return first.minus(second)
}


public func tail<T>(array: [T]) -> [T] {
    if array.count > 0 {
        return Array(array[1..<array.count])
    } else {
        return []
    }
}


extension Array {

    func shuffled() -> Array {
        return shuffle(self)
    }
    
    mutating func remove<U: Equatable>(itemToRemove: U) {
        let lastIndex = self.count - 1
        for (index, item) in Array(self.reverse()).enumerate() {
            if item as! U == itemToRemove {
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
        for (index, item) in self.enumerate() {
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
        for (index, element) in self.enumerate() {
            if element as? T == item {
                return index
            }
        }
        return nil
    }
    
    func indexOf(filter: (Element) -> Bool) -> Int? {
        for (index, item) in self.enumerate() {
            if filter(item) {
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

    func minus<T: Equatable>(other: [T]) -> [T] {
        var result = [T]()
        for item in self {
            // we need to coerce self to [T] in order to compare items
            // (otherwise we could write this "return self.filter { !other.contains($0) }"
            if let itemAsT = item as? T {
                if !other.contains(itemAsT) {
                    result.append(itemAsT)
                }
            }
        }
        return result
    }
    
    mutating func removeAtIndexes(indexes: [Int]) -> [T] {
        var removed = [T]()
        for index in indexes.sort(>) {
            removed.insert(self.removeAtIndex(index), atIndex: 0)
        }
        return removed
    }
    
}
