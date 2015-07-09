//
//  Sequence.swift
//  swift-utils
//
//  Created by Sven Schmidt on 15/12/2014.
//
//

import Foundation


struct TakeSequence<T: SequenceType>: SequenceType {
    private var numberOfItems: Int
    private var sequence: T
    init(_ numberOfItems: Int, _ sequence: T) {
        self.numberOfItems = numberOfItems
        self.sequence = sequence
    }
    func generate() -> AnyGenerator<T.Generator.Element> {
        var count = 0
        var generator = self.sequence.generate()
        return anyGenerator {
            if count < self.numberOfItems {
                count++
                return generator.next()
            } else {
                return nil
            }
        }
    }
}


extension AnySequence {
    func take(n: Int) -> AnySequence<Element> {
        return AnySequence(TakeSequence(n, self))
    }
}
