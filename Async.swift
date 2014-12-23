//
//  Async.swift
//  swift-utils
//
//  Created by Sven Schmidt on 21/11/2014.
//
//

import Foundation


func blockFor(timeout: NSTimeInterval, until: () -> Bool) {
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

typealias dispatch_cancelable_closure = (cancel : Bool) -> ()


func delay(time:NSTimeInterval, closure:()->()) ->  dispatch_cancelable_closure? {
    
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

func cancel_delay(closure:dispatch_cancelable_closure?) {
    
    if closure != nil {
        closure!(cancel: true)
    }
}

