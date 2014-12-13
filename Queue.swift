//
//  Queue.swift
//  swift-utils
//
//  Created by Sven Schmidt on 13/12/2014.
//
//

import Foundation


public class Queue<T> {
    private var data = [T]()
    var size: Int
    
    init(size: Int) {
        self.size = size
    }
    
    public func push(item: T) {
        self.data.append(item)
        if self.data.count > size {
            self.data.removeAtIndex(0)
        }
    }
    
    public func pop() -> T? {
        if self.data.count > 0 {
            return self.data.removeAtIndex(0)
        } else {
            return nil
        }
    }
    
    public func peek() -> T? {
        return self.data.first
    }
}
