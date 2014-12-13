//
//  RandomTests.swift
//  swift-utils
//
//  Created by Sven Schmidt on 13/12/2014.
//
//

import UIKit
import XCTest

class RandomTests: XCTestCase {

    func test_random() {
        let inclusiveMaxValue: UInt32 = 10
        let n = 1_000_000
        var minimum: UInt32 = UInt32.max
        var maximum: UInt32 = 0
        var mean: Double = 0
        for i in 0..<n {
            let r = random(inclusiveMaxValue)
            minimum = min(minimum, r)
            maximum = max(maximum, r)
            mean += Double(r)
        }
        mean /= Double(n)
        XCTAssertEqual(minimum, UInt32(0))
        XCTAssertEqual(maximum, inclusiveMaxValue)
        XCTAssertEqualWithAccuracy(mean, 5.0, 0.01)
    }
    
    func test_random_Double() {
        let n = 1_000_000
        var minimum: Double = 1
        var maximum: Double = 0
        var mean: Double = 0
        for i in 0..<n {
            let r: Double = random()
            minimum = min(minimum, r)
            maximum = max(maximum, r)
            mean += r
        }
        mean /= Double(n)
        XCTAssertEqualWithAccuracy(minimum, 0, 0.01)
        XCTAssertEqualWithAccuracy(maximum, 1, 0.01)
        XCTAssertEqualWithAccuracy(mean, 0.5, 0.01)
    }
    
    func test_shuffled() {
        var a = [Int]()
        for i in 0..<1000 {
            a.append(i)
        }
        XCTAssertNotEqual(a, a.shuffled())
        XCTAssertNotEqual(a.shuffled(), a.shuffled())
    }
    
}
