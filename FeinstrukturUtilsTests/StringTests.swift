//
//  StringTests.swift
//  swift-utils
//
//  Created by Sven Schmidt on 25/11/2014.
//
//

import UIKit
import XCTest
import Nimble


class StringTests: XCTestCase {

    func test_split() {
        let s = "a, b,c\td"
        expect(s.split()) == ["a", "b", "c", "d"]
    }
    
    
    func test_split_empty() {
        let s = ""
        expect(s.split()) == []
    }
    
    
    func test_split_dash() {
        expect("a-b".split("-")) == ["a", "b"]
        expect("ab".split("-")) == ["ab"]
    }
    
    
    func test_urlEncode() {
        let s = "!*'();:@&=+$,/?%#[]"
        expect(s.urlEncode()!) == "!*'();:@&=+$,/?%25%23%5B%5D"
    }
    
}
