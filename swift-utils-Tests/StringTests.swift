//
//  StringTests.swift
//  swift-utils
//
//  Created by Sven Schmidt on 25/11/2014.
//
//

import UIKit
import XCTest

class StringTests: XCTestCase {

    func test_split() {
        let s = "a, b,c\td"
        XCTAssertEqual(s.split(), ["a", "b", "c", "d"])
    }
    
}
