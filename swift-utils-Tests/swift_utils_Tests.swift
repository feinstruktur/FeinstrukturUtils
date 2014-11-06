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
    
    func test_shuffled() {
        var a = [Int]()
        for i in 0..<1000 {
            a.append(i)
        }
        XCTAssertNotEqual(a, a.shuffled())
        XCTAssertNotEqual(a.shuffled(), a.shuffled())
    }
 
    func test_remove() {
        var a = [0, 1, 2, 1, 3]
        a.remove(1)
        XCTAssertEqual(a, [0,2,3])
        var x = [0.0, 1.1, 2.2, 1.1, 3.3]
        x.remove(1.1)
        XCTAssertEqual(x, [0.0, 2.2, 3.3])
    }
}
