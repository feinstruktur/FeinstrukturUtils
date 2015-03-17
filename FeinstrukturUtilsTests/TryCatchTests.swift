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

class TryCatchTests: XCTestCase {

    func test_tryCatch() {
        
        if let error = try({ error in
            let res = doSomething(.Good, error)
            expect(res) == true
        }) {
            expect(false)
        }
        
        if let error = try({ error in
            let res = doSomething(.Bad, error)
            expect(res) == false
        }) {
            expect(error.code) == 42
        }
    }
    
}
