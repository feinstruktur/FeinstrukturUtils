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

    init(_ indexes: [Int]) {
        self.indexes = indexes
    }

    init(_ range: Range<Int>) {
        self.indexes = Array(range)
    }

    public func generate() -> AnyGenerator<Int> {
        var next = 0
        return anyGenerator {
            if (next == self.indexes.count) {
                return nil
            }
            return self.indexes[next++]
        }
    }

    mutating func addIndex(index: Int) {
        self.indexes.append(index)
    }
    
}


