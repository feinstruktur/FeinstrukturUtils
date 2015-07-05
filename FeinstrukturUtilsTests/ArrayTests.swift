//
//  swift_utils_Tests.swift
//  swift-utils-Tests
//
//  Created by Sven Schmidt on 05/11/2014.
//
//

import XCTest
import Nimble


class ArrayTests: XCTestCase {
    
    func test_shuffled_empty() {
        let a = [Int]()
        expect(a.shuffled()) == []
    }
 
    func test_shuffled_one() {
        let a = [1]
        expect(a.shuffled()) == [1]
    }
    
    func test_shuffled_two() {
        let a = [1, 2]
        // make sure this changes order with the expected split
        var equalCount = 0.0
        let iterations = 1000
        for _ in 0..<iterations {
            if a.shuffled() == a {
                equalCount++
            }
        }
        expect(equalCount/Double(iterations)) == 0.5 ± 0.05
    }
    
    func test_shuffled_three() {
        let a = [1, 2, 3]
        // make sure this changes order with the expected split
        var equalCount = 0.0
        let iterations = 1000
        for _ in 0..<iterations {
            if a.shuffled() == a {
                equalCount++
            }
        }
        expect(equalCount/Double(iterations)) == (1.0/3.0 * 1.0/2.0) ± 0.05
    }
    
    func test_remove() {
        var a = [0, 1, 2, 1, 3]
        a.remove(1)
        expect(a) == [0,2,3]
        var x = [0.0, 1.1, 2.2, 1.1, 3.3]
        x.remove(1.1)
        expect(x) == [0.0, 2.2, 3.3]
    }
    
    func test_each() {
        let a = [0, 1, 2, 3]
        var res = [Int]()
        a.each { res.append($0 + 1) }
        expect(res) == [1, 2, 3, 4]
    }
    
    func test_indexes() {
        let a = [0, 1, 4, 1, 3]
        expect(a.indexes(1)) == [1, 3]
        expect(a.indexes(4)) == [2]
        expect(a.indexes(5)) == []
    }
    
    func test_indexOf() {
        let i1 = ["0", "1", "2", "3"].indexOf("1")
        expect(i1!) == 1
        expect(["0", "1", "2", "3"].indexOf("5")).to(beNil())
        let i2 = ["0", "1", "2", "2", "3"].indexOf("2")
        expect(i2!) == 2
    }
    
    func test_indexOf_block() {
        let a = [-1, 0, 1, 2, 3, 4]
        expect(a.indexOf({ $0 > 0 && $0 % 2 == 0 })!) == 3
        expect(a.indexOf({ $0 > 5 })).to(beNil())
    }
    
    func test_contains() {
        expect(["0", "1", "2"].contains("1")) == true
        expect(["0", "1", "2"].contains("3")) == false
        expect(["0", "1", "2"].contains("1", "2")) == true
        expect(["0", "1", "2"].contains("2", "3")) == false
    }
    
    func test_first() {
        let a = [0, 1, 2, 3, 4]
        expect(a.first({ $0 > 0 && $0 % 2 == 0 })!) == 2
        expect(a.first({ $0 > 5 })).to(beNil())
    }
    
    func test_minus() {
        let a = [0, 1, 2, 3]
        let b = [1, 3]
        expect(a - b) == [0, 2]
        expect(b - a) == []
        expect(a - ["0"]) == a
    }
    
    func test_tail() {
        expect(tail([0,1,2])) == [1,2]
        expect(tail([0])) == []
        expect(tail([Int]())) == []
    }
    
    func test_remove_indexes() {
        var a = ["0", "1", "2", "3", "4"]
        expect(a.removeAtIndexes([1,3])) == ["1", "3"]
        expect(a) == ["0", "2", "4"]
    }
    
    func test_objectsAtIndexes() {
        let a = ["0", "1", "2", "3", "4"]
        let idx = IndexSet([1, 3])
        expect(a.objectsAtIndexes(idx)) == ["1", "3"]
    }

    func test_objectsAtIndexes_reverse() {
        let a = ["0", "1", "2", "3", "4"]
        let idx = IndexSet([3, 1])
        expect(a.objectsAtIndexes(idx)) == ["3", "1"]
    }

    func test_objectsAtIndexes_subscript() {
        let a = ["0", "1", "2", "3", "4"]
        let idx = IndexSet([1, 3])
        expect(a[idx]) == ["1", "3"]
    }
    
    func test_objectsAtIndexes_duplicates() {
        let a = ["0", "1", "2", "3", "4"]
        let idx = IndexSet([1, 1, 3, 2])
        expect(a[idx]) == ["1", "1", "3", "2"]
    }

    func test_multiplication() {
        let a = ["1", "2"]
        expect(a * 3) == ["1", "2", "1", "2", "1", "2"]
        expect(3 * a) == ["1", "2", "1", "2", "1", "2"]
    }
    
}
