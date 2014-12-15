//
//  AlgorithmsTests.swift
//  swift-utils
//
//  Created by Sven Schmidt on 15/12/2014.
//
//

import UIKit
import XCTest


class AlgorithmsTests: XCTestCase {

    func test_sum() {
        let s = sum([0,1,2])
        XCTAssertEqual(s, 3)
    }
    
    func test_sum_empty() {
        let s = sum([Int]())
        XCTAssertEqual(s, 0)
    }
    
}
