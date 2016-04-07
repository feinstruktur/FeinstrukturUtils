//
//  IndexSet.swift
//  FeinstrukturUtils
//
//  Created by Sven A. Schmidt on 03/07/2015.
//
//

import Foundation


public struct IndexSet: SequenceType {

    private var indexes: [Int]

    public init(_ indexes: [Int]) {
        self.indexes = indexes
    }

    public init(_ range: Range<Int>) {
        self.indexes = Array(range)
    }

    public func generate() -> AnyGenerator<Int> {
        var next = 0
        return AnyGenerator {
            if (next == self.indexes.count) {
                return nil
            }
            let res = self.indexes[next]
            next += 1
            return res
        }
    }

    mutating func addIndex(index: Int) {
        self.indexes.append(index)
    }
    
}


