//
//  XCTestCase+utils.swift
//  swift-utils
//
//  Created by Sven Schmidt on 21/11/2014.
//
//

import Foundation
import XCTest


extension XCTestCase {
    // TODO: blog post about wait until true function for tests
    
    func waitWithTimeout(timeout: NSTimeInterval, test: () -> Bool) {
        blockFor(timeout) { test() }
        XCTAssert(test())
    }

    
    // alternative implementation based on built-in expectations
    func expectation(@autoclosure(escaping) test: () -> Bool) -> XCTestCase {
        let expectation = expectationWithDescription("")
        let checkEveryInterval: NSTimeInterval = 0.01
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            while true {
                if test() {
                    expectation.fulfill()
                    break
                }
                NSThread.sleepForTimeInterval(checkEveryInterval)
            }
        }
        return self
    }
    
}

