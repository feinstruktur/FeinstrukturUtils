//
//  SequenceTests.swift
//  swift-utils
//
//  Created by Sven Schmidt on 15/12/2014.
//
//

import UIKit
import XCTest
import Nimble


struct Fibonacci: SequenceType {
    func generate() -> GeneratorOf<Int> {
        var current = 0
        var next = 1
        return GeneratorOf<Int> {
            let res = current
            current = next
            next = res + current
            return res
        }
    }
}


class SequenceTests: XCTestCase {

    func test_take() {
        let source = SequenceOf(Fibonacci())
        expect(Array(source.take(8))) == [0, 1, 1, 2, 3, 5, 8, 13]
        expect(Array(source.take(0))) == []
    }
    
}
