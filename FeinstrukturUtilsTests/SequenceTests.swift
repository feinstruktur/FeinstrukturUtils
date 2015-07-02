//
//  SequenceTests.swift
//  swift-utils
//
//  Created by Sven Schmidt on 15/12/2014.
//
//

import XCTest
import Nimble


struct Fibonacci: SequenceType {
    func generate() -> AnyGenerator<Int> {
        var current = 0
        var next = 1
        return anyGenerator {
            let res = current
            current = next
            next = res + current
            return res
        }
    }
}


class SequenceTests: XCTestCase {

    func test_take() {
        let source = AnySequence(Fibonacci())
        expect(Array(source.take(8))) == [0, 1, 1, 2, 3, 5, 8, 13]
        expect(Array(source.take(0))) == []
    }
    
}
