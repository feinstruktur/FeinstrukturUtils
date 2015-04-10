//
//  Utils.swift
//  FeinstrukturUtils
//
//  Created by Sven Schmidt on 10/04/2015.
//
//

import Foundation


// Simple timing function, printing the time spent running the block. Use this to wrap a method with a return value.
public func time<T>(label: String, block: Void -> T) -> T {
    let start = NSDate()
    let res = block()
    let elapsed = NSDate().timeIntervalSinceDate(start)
    NSLog("\(label): %@", NSString(format: "%.2f", elapsed))
    return res
}


// Simple timing function, printing the time spent running the block (without return value).
public func time(label: String, block: Void -> Void) {
    let start = NSDate()
    block()
    let elapsed = NSDate().timeIntervalSinceDate(start)
    NSLog("\(label): %@", NSString(format: "%.2f", elapsed))
}
