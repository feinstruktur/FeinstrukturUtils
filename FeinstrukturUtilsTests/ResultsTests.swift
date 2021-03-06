//
//  ResultsTests.swift
//  swift-utils
//
//  Created by Sven Schmidt on 30/01/2015.
//
//

import XCTest
import Nimble


let error = NSError(domain: "", code: 0, userInfo: nil)


class ResultsTests: XCTestCase {

    func test_init_succeeded_failed() {
        expect(Result<String>("foo").succeeded) == true
        expect(Result<String>("foo").failed) == false
        expect(Result<String>(error).succeeded) == false
        expect(Result<String>(error).failed) == true
    }

    
    func test_value() {
        expect(Result<String>("foo").value!) == "foo"
        expect(Result<String>(error).value).to(beNil())
    }


    func test_error() {
        expect(Result<String>(error).error! == error) == true
        expect(Result<String>("foo").error).to(beNil())
    }
    
}
