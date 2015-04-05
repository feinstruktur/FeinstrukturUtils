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
        
        if let res = try({ error in doSomething2(.Good, error) }).value {
            expect(res) == "Success"
        } else {
            fail()
        }

        if let res = try({ error in doSomething2(.Bad, error) }).value {
            fail()
        } else {
            expect(true)
        }

        // long versions
        
        switch try({ error in doSomething(.Good, error) }) {
        case .Success(let value):
            expect(value.unbox) == true
        case .Failure(let error):
            expect(error.code) == 42
        }

        switch try({ error in doSomething(.Bad, error) }) {
        case .Success(let value):
            expect(value.unbox) == true
        case .Failure(let error):
            expect(error.code) == 42
        }

    }
    
}
