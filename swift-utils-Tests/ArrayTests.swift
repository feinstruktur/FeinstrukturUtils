//
//  swift_utils_Tests.swift
//  swift-utils-Tests
//
//  Created by Sven Schmidt on 05/11/2014.
//
//

import UIKit
import XCTest


class ArrayTests: XCTestCase {
    
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
    
    func test_shuffled() {
        var a = [Int]()
        for i in 0..<1000 {
            a.append(i)
        }
        XCTAssertNotEqual(a, a.shuffled())
        XCTAssertNotEqual(a.shuffled(), a.shuffled())
    }
    
    func test_shuffled_empty() {
        let a = [Int]()
        XCTAssertEqual(a.shuffled().count, 0)
    }
 
    func test_remove() {
        var a = [0, 1, 2, 1, 3]
        a.remove(1)
        XCTAssertEqual(a, [0,2,3])
        var x = [0.0, 1.1, 2.2, 1.1, 3.3]
        x.remove(1.1)
        XCTAssertEqual(x, [0.0, 2.2, 3.3])
    }
    
    func test_each() {
        var a = [0, 1, 2, 3]
        var res = [Int]()
        a.each { res.append($0 + 1) }
        XCTAssertEqual(res, [1, 2, 3, 4])
    }
    
    func test_indexes() {
        var a = [0, 1, 4, 1, 3]
        XCTAssertEqual(a.indexes(1), [1, 3])
        XCTAssertEqual(a.indexes(4), [2])
        XCTAssertEqual(a.indexes(5), [])
    }
    
    func test_indexOf() {
        let i1 = ["0", "1", "2", "3"].indexOf("1")
        XCTAssertEqual(i1!, 1)
        XCTAssertNil(["0", "1", "2", "3"].indexOf("5"))
        let i2 = ["0", "1", "2", "2", "3"].indexOf("2")
        XCTAssertEqual(i2!, 2)
    }
    
    func test_contains() {
        XCTAssert(["0", "1", "2"].contains("1"))
        XCTAssertFalse(["0", "1", "2"].contains("3"))
        XCTAssert(["0", "1", "2"].contains("1", "2"))
        XCTAssertFalse(["0", "1", "2"].contains("2", "3"))
    }
    
}
