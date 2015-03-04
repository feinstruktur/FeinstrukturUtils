//
//  AsyncTests.swift
//  swift-utils
//
//  Created by Sven Schmidt on 21/11/2014.
//
//

import UIKit
import XCTest

class AsyncTests: XCTestCase {

    func test_blockFor() {
        let timeout = 0.5
        let start = NSDate()
        var fired = false
        blockFor(timeout) {
            fired = true
            return true
        }
        let elapsed = NSDate().timeIntervalSinceDate(start)
        XCTAssert(elapsed < timeout)
        XCTAssert(fired)
    }

    
    func test_blockFor_timeout() {
        let timeout = 0.5
        let start = NSDate()
        var fired = false
        blockFor(timeout) {
            fired = true
            return false
        }
        let elapsed = NSDate().timeIntervalSinceDate(start)
        XCTAssert(elapsed >= timeout)
        XCTAssert(fired)
    }

}
