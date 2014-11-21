//
//  XCTestCase+utilsTests.swift
//  swift-utils
//
//  Created by Sven Schmidt on 21/11/2014.
//
//

import UIKit
import XCTest


class XCTestCase_utilsTests: XCTestCase {

    func test_waitWithTimeout_positive() {
        let start = NSDate()
        var fired = false
        blockFor(0.1) {
            fired = true
            return false
        }
        self.waitWithTimeout(1) {
            return fired
        }
        let elapsed = NSDate().timeIntervalSinceDate(start)
        // elapsed should be a little larger than 0.1
        XCTAssert(elapsed >= 0.1)
        XCTAssert(elapsed < 0.4)
    }

    func test_waitWithTimeout_negative() {
        let start = NSDate()
        var fired = false
        blockFor(0.2) {
            fired = true
            return false
        }
        self.waitWithTimeout(0.1) {
            return fired
        }
        let elapsed = NSDate().timeIntervalSinceDate(start)
        // elapsed should be a little larger than 0.1
        XCTAssert(elapsed >= 0.1)
        XCTAssert(elapsed < 0.4)
    }
    
}
