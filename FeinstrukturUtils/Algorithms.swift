//
//  Algorithms.swift
//  swift-utils
//
//  Created by Sven Schmidt on 15/12/2014.
//
//

import Foundation


public protocol Addable {
    func +(lhs: Self, rhs: Self) -> Self
    static func zero() -> Self
}


extension Double: Addable {
    public static func zero() -> Double {
        return 0.0
    }
}


extension Int: Addable {
    public static func zero() -> Int {
        return 0
    }
}


public func sum<T: Addable>(values: [T]) -> T {
    if values.count > 0 {
        return values.reduce(T.zero()) { $0 + $1 }
    } else {
        return T.zero()
    }
}


extension Int {
    public func times(block: Void -> Void) {
        if self > 0 {
            for _ in 0..<self {
                block()
            }
        }
    }
}

