//
//  AsyncTests.swift
//  swift-utils
//
//  Created by Sven Schmidt on 21/11/2014.
//
//

import UIKit
import XCTest
import Nimble


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
        expect(elapsed) < timeout
        expect(fired) == true
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
        expect(elapsed) >= timeout
        expect(fired) == true
    }


    func test_Throttle() {
        var t = Throttle(bufferTime: 0.01)
        var count = 0
        mainQueue {
            for i in 0..<1000 {
                t.execute {
                    println("### \(count)")
                    count++
                }
            }
        }
//        blockFor(0.02) { false }
        expect(count).toEventually(equal(100), timeout: 0.5)
    }

}
