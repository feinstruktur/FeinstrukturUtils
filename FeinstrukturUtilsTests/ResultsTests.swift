//
//  ResultsTests.swift
//  swift-utils
//
//  Created by Sven Schmidt on 30/01/2015.
//
//

import UIKit
import XCTest
import Nimble

class ResultsTests: XCTestCase {

    func test_init_succeeded_failed() {
        expect(Result<String>("foo").succeeded) == true
        expect(Result<String>("foo").failed) == false
        expect(Result<String>(NSError()).succeeded) == false
        expect(Result<String>(NSError()).failed) == true
    }

    
    func test_value() {
        expect(Result<String>("foo").value!) == "foo"
        expect(Result<String>(NSError()).value).to(beNil())
    }


    func test_error() {
        let error = NSError()
        expect(Result<String>(error).error! == error) == true
        expect(Result<String>("foo").error).to(beNil())
    }
    
    
    // http://owensd.io/2014/08/06/fixed-enum-layout.html
    // (this is why we need to use Success(Box<T>) instead of Success(@autoclosure() -> T)
    func test_idempotence() {
        var v: Int = 0
        var r = Result(v++)
        expect(r.value!) == 0
        expect(r.value!) == 0
    }
    
}
