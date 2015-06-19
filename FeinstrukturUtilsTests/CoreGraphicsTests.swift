//
//  CoreGraphicsTests.swift
//  swift-utils
//
//  Created by Sven Schmidt on 04/03/2015.
//
//

import XCTest
import Nimble


let a = CGPoint(x: 1, y: 2)
let b = CGPoint(x: 2, y: 3)
let c = CGPoint(x: 3, y: 6)
let s = CGSize(width: 10, height: 20)


class CGPointTests: XCTestCase {

    func test_addition() {
        expect(a + b) == CGPoint(x: 3, y: 5)
        expect(b + a) == CGPoint(x: 3, y: 5)
        expect(a + (2.0, 3.0)) == CGPoint(x: 3, y: 5)
        expect(a + (2, 3)) == CGPoint(x: 3, y: 5)
    }
    
    func test_subtraction() {
        expect(a - c) == CGPoint(x: -2, y: -4)
        expect(c - b) == CGPoint(x: 1, y: 3)
        expect(a - s) == CGPoint(x: -9, y: -18)
        expect(a - (3, 5)) == CGPoint(x: -2, y: -3)
    }
    
    func test_division() {
        expect(a / 2) == CGPoint(x: 0.5, y: 1)
    }
    
    func test_augmentedAddition() {
        var x = a
        x += b
        expect(x) == a + b
    }
    
    func test_augmentedSubtraction() {
        var x = a
        x -= c
        expect(x) == a - c
    }
    
    func test_initWithSize() {
        expect(CGPoint(size: s)) == CGPoint(x: 10, y: 20)
    }
    
}


let t = CGSize(width: 15, height: 40)


class CGSizeTests: XCTestCase {

    func test_addition() {
        expect(s + t) == CGSize(width: 25, height: 60)
        expect(s + (5, 10)) == CGSize(width: 15, height: 30)
    }
    
    func test_subtraction() {
        expect(s - t) == CGSize(width: -5, height: -20)
        expect(t - s) == CGSize(width: 5, height: 20)
    }
    
    func test_division() {
        expect(s / 2) == CGSize(width: 5, height: 10)
    }
    
}


class CGRectTests: XCTestCase {
    
    func test_withPadding() {
        let r = CGRect(x: 1, y: 2, width: 5, height: 10)
        expect(r.withPadding(x: 5, y: 15)) == CGRect(x: -4, y: -13, width: 15, height: 40)
    }
    
}



class TupleTests: XCTestCase {

    func test_multiplication() {
        let x: (CGFloat, CGFloat) = (1, 2)
        var res = 2.5 * x
        expect(res.0) == 2.5
        expect(res.1) == 5.0
        res = x * 2.5
        expect(res.0) == 2.5
        expect(res.1) == 5.0
    }
    
}

