//
//  QueueTests.swift
//  swift-utils
//
//  Created by Sven Schmidt on 13/12/2014.
//
//

import UIKit
import XCTest
import Nimble


class QueueTests: XCTestCase {

    func test_Queue() {
        let q = Queue<Int>(size: 3)
        XCTAssertNil(q.pop())
        q.push(1)
        XCTAssertEqual(q.pop()!, 1)
        XCTAssertNil(q.pop())
        q.push(1)
        q.push(2)
        q.push(3)
        q.push(4)
        expect(q.pop()!) == 2
        expect(q.pop()!) == 3
        expect(q.pop()!) == 4
        expect(q.pop()).to(beNil())
    }
    
    func test_peek() {
        let q = Queue<Int>(size: 3)
        q.push(1)
        expect(q.peek()!) == 1
        expect(q.pop()!) == 1
        expect(q.peek()).to(beNil())
    }
    
    func test_values() {
        let q = Queue<Int>(size: 3)
        q.push(1)
        q.push(2)
        let values = q.values
        expect(values) == [1, 2]
        q.push(3)
        expect(values) == [1, 2]
    }
    
    func test_contains() {
        let q = Queue<Int>(size: 3)
        q.push(1)
        q.push(2)
        expect(q.contains(1)) == true
        expect(q.contains(2)) == true
        expect(q.contains(3)) == false
    }
    
}
