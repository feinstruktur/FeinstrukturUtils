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
    func generate() -> GeneratorOf<T.Generator.Element> {
        var count = 0
        var generator = self.sequence.generate()
        return GeneratorOf<T.Generator.Element> {
            if count < self.numberOfItems {
                count++
                return generator.next()
            } else {
                return nil
            }
        }
    }
}


extension SequenceOf {
    func take(n: Int) -> SequenceOf<T> {
        return SequenceOf(TakeSequence(n, self))
    }
}
