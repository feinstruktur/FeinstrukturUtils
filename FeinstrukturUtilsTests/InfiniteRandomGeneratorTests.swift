//
//  InfiniteRandomGeneratorTests.swift
//  swift-utils
//
//  Created by Sven Schmidt on 08/11/2014.
//
//

import XCTest
import Nimble


class InfiniteRandomGeneratorTests: XCTestCase {
    
    func tests_next() {
        let deckSize = 20
        let iterations = 10
        let items = Array((0..<deckSize))
        var dealer = InfiniteRandomGenerator<Int>(array: items)
        var randomItems = [Int]()
        for _ in 0..<iterations*deckSize {
            randomItems.append(dealer.next()!)
        }

        expect(randomItems.count) == iterations * deckSize
        
        items.each { (index, item) in
            let indexes = randomItems.indexes(item)
            expect(indexes.count) == iterations
            // make sure all cards are at least half a deck apart (indexes are given in order)
            for i in 1..<indexes.count {
                let distance = abs(indexes[i-1] - indexes[i])
                expect(distance) > items.count / 2
            }
        }
    }
    
    func test_next_empty() {
        var dealer = InfiniteRandomGenerator<Int>(array: [Int]())
        expect(dealer.next()).to(beNil())
    }

    func test_next_one() {
        var dealer = InfiniteRandomGenerator<Int>(array: [1])
        expect(dealer.next()!) == 1
        expect(dealer.next()!) == 1
        expect(dealer.next()!) == 1
    }
    
    func test_next_two() {
        var firstValueIsZero = 0.0
        let iterations = 1000
        for _ in 0..<iterations {
            var dealer = InfiniteRandomGenerator<Int>(array: [0, 1])
            let firstValue = dealer.next()!
            if firstValue == 1 {
                firstValueIsZero += 1
            }
            expect(dealer.next()!) == (firstValue + 1) % 2
            expect(dealer.next()!) == firstValue
            expect(dealer.next()!) == (firstValue + 1) % 2
            expect(dealer.next()!) == firstValue
        }
        expect(firstValueIsZero/Double(iterations)) == 0.5 ± 0.05
    }
    
}
