//
//  AsyncTests.swift
//  swift-utils
//
//  Created by Sven Schmidt on 21/11/2014.
//
//

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

    
    func test_delay() {
        let timeout = 0.5
        let start = NSDate()
        var stop: NSDate?
        delay(timeout) {
            stop = NSDate()
        }
        expect(stop).toEventuallyNot(beNil())
        let elapsed = stop?.timeIntervalSinceDate(start)
        expect(elapsed) >= timeout
    }
    

    func test_Timer() {
        let interval: NSTimeInterval = 0.2
        let q = dispatch_queue_create("queue", DISPATCH_QUEUE_SERIAL)
        var count = 0
        let t = Timer(interval: interval, queue: q) {
            count += 1
        }
        expect(t).notTo(beNil())
        
        blockFor(5.5 * interval) { false }
        expect(count) == 5
    }
    
    
    func test_Throttle() {
        var count = 0
        var t = Throttle(bufferTime: 0.01)
        let incrementLots: (Void -> Void) = {
            for _ in 0..<1000 {
                // all these blocks execute within the 10ms buffer time, therefore only one is actually run
                t.execute {
                    count += 1
                }
            }
        }

        incrementLots()
        blockFor(0.011) { false }

        expect(count).toEventually(equal(1), timeout: 0.5)
        
        incrementLots()
        blockFor(0.011) { false }

        expect(count).toEventually(equal(2), timeout: 0.5)
    }

}
