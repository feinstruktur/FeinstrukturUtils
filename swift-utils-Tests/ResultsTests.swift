//
//  ResultsTests.swift
//  swift-utils
//
//  Created by Sven Schmidt on 30/01/2015.
//
//

import UIKit
import XCTest

class ResultsTests: XCTestCase {

    func test_init_succeeded_failed() {
        XCTAssertTrue(Result<String>("foo").succeeded)
        XCTAssertFalse(Result<String>("foo").failed)
        XCTAssertFalse(Result<String>(NSError()).succeeded)
        XCTAssertTrue(Result<String>(NSError()).failed)
    }

    
    func test_value() {
        XCTAssertEqual(Result<String>("foo").value!, "foo")
        XCTAssertNil(Result<String>(NSError()).value)
    }


    func test_error() {
        let error = NSError()
        XCTAssertEqual(Result<String>(error).error!, error)
        XCTAssertNil(Result<String>("foo").error)
    }
    
    
    // http://owensd.io/2014/08/06/fixed-enum-layout.html
    // (this is why we need to use Success(Box<T>) instead of Success(@autoclosure() -> T)
    func test_idempotence() {
        var v: Int = 0
        var r = Result(v++)
        XCTAssertEqual(r.value!, 0)
        XCTAssertEqual(r.value!, 0)
    }
    
}
