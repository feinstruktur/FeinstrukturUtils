//
//  InfiniteRandomGeneratorTests.swift
//  swift-utils
//
//  Created by Sven Schmidt on 08/11/2014.
//
//

import UIKit
import XCTest


class InfiniteRandomGeneratorTests: XCTestCase {
    
    func tests_next() {
        let deckSize = 20
        let iterations = 10
        let items = Array((0..<deckSize))
        var dealer = InfiniteRandomGenerator<Int>(array: items)
        var randomItems = [Int]()
        for i in 0..<iterations*deckSize {
            randomItems.append(dealer.next()!)
        }
        XCTAssertEqual(randomItems.count, iterations*deckSize)
        items.each { (index, item) in
            let indexes = randomItems.indexes(item)
            XCTAssertEqual(indexes.count, iterations, NSString(format: "fails for: %d", item))
            // make sure all cards are at least half a deck apart (indexes are given in order)
            for i in 1..<indexes.count {
                let distance = abs(indexes[i-1] - indexes[i])
                XCTAssert(distance > items.count/2)
            }
        }
    }
    
    func test_next_empty() {
        var dealer = InfiniteRandomGenerator<Int>(array: [Int]())
        XCTAssertNil(dealer.next())
    }

    func test_next_one() {
        var dealer = InfiniteRandomGenerator<Int>(array: [1])
        XCTAssertEqual(dealer.next()!, 1)
        XCTAssertEqual(dealer.next()!, 1)
        XCTAssertEqual(dealer.next()!, 1)
    }
    
    func test_next_two() {
        var firstValueIsZero = 0.0
        let iterations = 1000
        for i in 0..<iterations {
            var dealer = InfiniteRandomGenerator<Int>(array: [0, 1])
            let firstValue = dealer.next()!
            if firstValue == 1 {
                firstValueIsZero++
            }
            XCTAssertEqual(dealer.next()!, (firstValue + 1) % 2)
            XCTAssertEqual(dealer.next()!, firstValue)
            XCTAssertEqual(dealer.next()!, (firstValue + 1) % 2)
            XCTAssertEqual(dealer.next()!, firstValue)
        }
        XCTAssertEqualWithAccuracy(firstValueIsZero/Double(iterations), 0.5, 0.05)
    }
    
}
