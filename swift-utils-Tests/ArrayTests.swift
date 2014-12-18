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
    
    func test_shuffled_empty() {
        let a = [Int]()
        XCTAssertEqual(a.shuffled().count, 0)
    }
 
    func test_shuffled_one() {
        let a = [1]
        XCTAssertEqual(a.shuffled(), [1])
    }
    
    func test_shuffled_two() {
        let a = [1, 2]
        // make sure this changes order with the expected split
        var equalCount = 0.0
        let iterations = 1000
        for i in 0..<iterations {
            if a.shuffled() == a {
                equalCount++
            }
        }
        XCTAssertEqualWithAccuracy(equalCount/Double(iterations), 0.5, 0.05)
    }
    
    func test_shuffled_three() {
        let a = [1, 2, 3]
        // make sure this changes order with the expected split
        var equalCount = 0.0
        let iterations = 1000
        for i in 0..<iterations {
            if a.shuffled() == a {
                equalCount++
            }
        }
        XCTAssertEqualWithAccuracy(equalCount/Double(iterations), 1.0/3.0 * 1.0/2.0, 0.05)
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
    
    func test_indexOf_block() {
        let a = [-1, 0, 1, 2, 3, 4]
        XCTAssertEqual(a.indexOf({ $0 > 0 && $0 % 2 == 0 })!, 3)
        XCTAssertNil(a.indexOf({ $0 > 5 }))
    }
    
    func test_contains() {
        XCTAssert(["0", "1", "2"].contains("1"))
        XCTAssertFalse(["0", "1", "2"].contains("3"))
        XCTAssert(["0", "1", "2"].contains("1", "2"))
        XCTAssertFalse(["0", "1", "2"].contains("2", "3"))
    }
    
    func test_first() {
        let a = [0, 1, 2, 3, 4]
        XCTAssertEqual(a.first({ $0 > 0 && $0 % 2 == 0 })!, 2)
        XCTAssertNil(a.first({ $0 > 5 }))
    }
    
    func test_minus() {
        let a = [0, 1, 2, 3]
        let b = [1, 3]
        XCTAssertEqual(a - b, [0, 2])
        XCTAssertEqual(b - a, [])
        XCTAssertEqual(a - ["0"], a)
    }
    
    func test_tail() {
        XCTAssertEqual(tail([0,1,2]), [1,2])
        XCTAssertEqual(tail([0]), [])
        XCTAssertEqual(tail([Int]()), [])
    }
    
    func test_remove_indexes() {
        var a = ["0", "1", "2", "3", "4"]
        XCTAssertEqual(a.removeAtIndexes([1,3]), ["1", "3"])
        XCTAssertEqual(a, ["0", "2", "4"])
    }
    
}
