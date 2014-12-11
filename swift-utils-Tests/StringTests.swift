//
//  StringTests.swift
//  swift-utils
//
//  Created by Sven Schmidt on 25/11/2014.
//
//

import UIKit
import XCTest

class StringTests: XCTestCase {

    func test_split() {
        let s = "a, b,c\td"
        XCTAssertEqual(s.split(), ["a", "b", "c", "d"])
    }
    
    
    func test_split_empty() {
        let s = ""
        XCTAssertEqual(s.split(), [])
    }
    
    
    func test_split_dash() {
        XCTAssertEqual("a-b".split("-"), ["a", "b"])
        XCTAssertEqual("ab".split("-"), ["ab"])
    }
    
    
    func test_urlEncode() {
        let s = "!*'();:@&=+$,/?%#[]"
        XCTAssertEqual(s.urlEncode()!, "!*'();:@&=+$,/?%25%23%5B%5D")
    }
    
}
