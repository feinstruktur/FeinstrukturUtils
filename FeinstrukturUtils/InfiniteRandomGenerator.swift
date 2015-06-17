//
//  InfiniteRandomGenerator.swift
//  swift-utils
//
//  Created by Sven Schmidt on 08/11/2014.
//
//

import Foundation


struct InfiniteRandomGenerator<T: Equatable>: GeneratorType {
    typealias Element = T
    var array: [Element]
    var shuffledArray: [Element]
    var history: [Element]
    var historySize: Int
    
    init(array: [Element]) {
        self.array = array
        self.shuffledArray = shuffle(array)
        self.history = []
        // History size ensures that when stitching two shuffled sets together the beginning of the second set will not repeat elements seen at the end of the previous one, avoiding things like [ ... , 17, 42] followed by [42, 17, ... ]. This parameter could be configurable.
        self.historySize = self.array.count/2
    }
    
    mutating func next() -> Element? {
        if self.shuffledArray.count > 0 {
            let item =  self.shuffledArray.removeLast()
            if history.contains(item) {
                // the item is in the history - put it back to the bottom of the shuffled stack and get the next one off the top
                self.shuffledArray.insert(item, atIndex: 0)
                return self.next()
            } else {
                // the item is not in the history - record it in the history and return it
                self.history.append(item)
                if self.history.count > historySize {
                    // pop the oldest item off the history stack if it's too large
                    self.history.removeAtIndex(0)
                }
                return item
            }
        } else {
            // we have exhausted our shuffled stack - if we actually have cards we reshuffle and get the next item off the top, otherwise we return nil
            if self.array.count > 0 {
                self.shuffledArray = shuffle(self.array)
                return self.next()
            } else {
                return nil
            }
        }
    }
    
}
