//
//  Result.swift
//  swift-utils
//
//  Created by Sven Schmidt on 30/01/2015.
//
//

import Foundation


public class Box<T> {
    public let unbox: T
    init(_ value: T) { self.unbox = value }
}


public enum Result<T> {
    case Success(Box<T>)
    case Failure(NSError)
    
    public init(_ value: T) { self = .Success(Box(value)) }
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
            return value.unbox
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
