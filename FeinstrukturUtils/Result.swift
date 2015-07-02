//
//  Result.swift
//  swift-utils
//
//  Created by Sven Schmidt on 30/01/2015.
//
//

import Foundation


public func map<T, U>(result: Result<T>, f: T -> U) -> Result<U> {
    switch result {
    case .Success(let value):
        return Result(f(value))
    case .Failure(let error):
        return Result(error)
    }
}


public enum Result<T> {
    case Success(T)
    case Failure(NSError)
    
    public init(_ value: T) { self = .Success(value) }
    public init(_ error: NSError) { self = .Failure(error) }
    
    public var succeeded: Bool {
        switch self {
        case .Success:
            return true
        default:
            return false
        }
    }
    
    public var failed: Bool {
        return !self.succeeded
    }
    
    public var value: T? {
        switch self {
        case .Success(let value):
            return value
        default:
            return nil
        }
    }
    
    public var error: NSError? {
        switch self {
        case .Failure(let error):
            return error
        default:
            return nil
        }
    }

}
