//
//  Try.swift
//  FeinstrukturUtils
//
//  Created by Sven Schmidt on 05/04/2015.
//
//

import Foundation


func try(block: NSErrorPointer -> Void) -> NSError? {
    var error: NSError?
    block(&error)
    return error
}

func try<T>(block: NSErrorPointer -> T) -> Result<T> {
    var error: NSError?
    let res = block(&error)
    if error == nil {
        return Result(res)
    } else {
        return Result(error!)
    }
}

// specialisation for Bool, because Bool return values signal stronger than NSError (for example in Core Data)
func try(block: NSErrorPointer -> Bool) -> Result<Bool> {
    var error: NSError?
    let res = block(&error)
    if res {
        return Result(res)
    } else {
        return Result(error!)
    }
}

