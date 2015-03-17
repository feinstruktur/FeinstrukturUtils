//
//  TryCatchTests.swift
//  FeinstrukturUtils
//
//  Created by Sven Schmidt on 17/03/2015.
//
//

import UIKit
import XCTest
import Nimble


func try(block: NSErrorPointer -> Void) -> NSError? {
    var error: NSError?
    block(&error)
    return error
}

func try2<T>(block: NSErrorPointer -> T) -> Result<T> {
    var error: NSError?
    let res = block(&error)
    if error == nil {
        return Result(res)
    } else {
        return Result(error!)
    }
}

// TODO: enable once API is settled
// specialisation for Bool, because Bool return values signal stronger than NSError (for example in Core Data)
//func try2(block: NSErrorPointer -> Bool) -> Result<Bool> {
//    var error: NSError?
//    let res = block(&error)
//    if res {
//        return Result(res)
//    } else {
//        return Result(error!)
//    }
//}

enum Param {
    case Good, Bad
}

func doSomething(param: Param, error: NSErrorPointer) -> Bool {
    switch param {
    case .Good:
        error.memory = nil
        return true
    case .Bad:
        error.memory = NSError(domain: "Test", code: 42, userInfo: ["Key": "Value"])
        return false
    }
}

func doSomething2(param: Param, error: NSErrorPointer) -> String {
    switch param {
    case .Good:
        error.memory = nil
        return "Success"
    case .Bad:
        error.memory = NSError(domain: "Test", code: 42, userInfo: ["Key": "Value"])
        return "Failure"
    }
}


class TryCatchTests: XCTestCase {

    func test_try() {
        
        if let error = try({ error in
            let res = doSomething(.Good, error)
            expect(res) == true
        }) {
            fail()
        }
        
        if let error = try({ error in
            let res = doSomething(.Bad, error)
            expect(res) == false
        }) {
            expect(error.code) == 42
        }

    }
    
    func test_try2() {
        
        // short circuit versions
        
        if let res = try2({ error in doSomething2(.Good, error) }).value {
            expect(res) == "Success"
        } else {
            fail()
        }

        if let res = try2({ error in doSomething2(.Bad, error) }).value {
            fail()
        } else {
            expect(true)
        }

        // long versions
        
        switch try2({ error in doSomething(.Good, error) }) {
        case .Success(let value):
            expect(value.unbox) == true
        case .Failure(let error):
            expect(error.code) == 42
        }

        switch try2({ error in doSomething(.Bad, error) }) {
        case .Success(let value):
            expect(value.unbox) == true
        case .Failure(let error):
            expect(error.code) == 42
        }

    }
    
}
