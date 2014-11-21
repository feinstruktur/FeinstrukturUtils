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


