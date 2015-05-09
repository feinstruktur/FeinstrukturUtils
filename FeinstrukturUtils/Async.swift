//
//  Async.swift
//  swift-utils
//
//  Created by Sven Schmidt on 21/11/2014.
//
//

import Foundation


public struct Timer {
    private let timer: dispatch_source_t

    public init(interval: NSTimeInterval, queue: dispatch_queue_t = dispatch_get_main_queue(), block: (Void -> Void)) {
        self.timer = {
            let t = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue)
            let interval_ns = UInt64(interval * NSTimeInterval(NSEC_PER_SEC))
            let start = dispatch_time(DISPATCH_TIME_NOW, Int64(interval_ns))
            dispatch_source_set_timer(t, start, interval_ns, interval_ns/1000)
            dispatch_source_set_event_handler(t, block)
            dispatch_resume(t)
            return t
            }()
    }

    public func cancel() {
        dispatch_source_cancel(self.timer)
    }
    
}


public func mainQueue(block: Void -> Void) {
    NSOperationQueue.mainQueue().addOperationWithBlock {
        block()
    }
}


public func blockFor(timeout: NSTimeInterval, until: () -> Bool) {
    let runLoopModes = [NSDefaultRunLoopMode, NSRunLoopCommonModes]
    let checkEveryInterval: NSTimeInterval = 0.01
    let runUntilDate = NSDate(timeIntervalSinceNow: timeout)
    var runIndex = 0
    
    while !until() {
        let mode = runLoopModes[runIndex++ % runLoopModes.count]
        
        autoreleasepool {
            let checkDate = NSDate(timeIntervalSinceNow: checkEveryInterval)
            if !NSRunLoop.currentRunLoop().runMode(mode, beforeDate: checkDate) {
                NSThread.sleepForTimeInterval(checkEveryInterval)
            }
        }
        
        if runUntilDate.compare(NSDate()) == .OrderedAscending {
            break
        }
    }
}

// TODO: tests

//  Usage:
//
//  let retVal = delay(2.0) {
//    println("Later")
//  }
//
//  delay(1.0) {
//    cancel_delay(retVal)
//  }
//
// Ref: http://sebastienthiebaud.us/blog/ios/gcd/block/2014/04/09/diggint-into-gcd-1-cancel-dispatch-after.html
//

public typealias dispatch_cancelable_closure = (cancel : Bool) -> ()


public func delay(time:NSTimeInterval, closure:()->()) ->  dispatch_cancelable_closure? {
    
    func dispatch_later(clsr:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(time * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), clsr)
    }
    
    var closure:dispatch_block_t? = closure
    var cancelableClosure:dispatch_cancelable_closure?
    
    let delayedClosure:dispatch_cancelable_closure = { cancel in
        if let clsr = closure {
            if (cancel == false) {
                dispatch_async(dispatch_get_main_queue(), clsr);
            }
        }
        closure = nil
        cancelableClosure = nil
    }
    
    cancelableClosure = delayedClosure
    
    dispatch_later {
        if let delayedClosure = cancelableClosure {
            delayedClosure(cancel: false)
        }
    }
    
    return cancelableClosure;
}

public func cancel_delay(closure:dispatch_cancelable_closure?) {
    
    if closure != nil {
        closure!(cancel: true)
    }
}

