//
//  QueueTests.swift
//  swift-utils
//
//  Created by Sven Schmidt on 13/12/2014.
//
//

import UIKit
import XCTest


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
        XCTAssertEqual(q.pop()!, 2)
        XCTAssertEqual(q.pop()!, 3)
        XCTAssertEqual(q.pop()!, 4)
        XCTAssertNil(q.pop())
    }
    
    func test_peek() {
        let q = Queue<Int>(size: 3)
        q.push(1)
        XCTAssertEqual(q.peek()!, 1)
        XCTAssertEqual(q.pop()!, 1)
        XCTAssertNil(q.peek())
    }
    
    func test_values() {
        let q = Queue<Int>(size: 3)
        q.push(1)
        q.push(2)
        let values = q.values
        XCTAssertEqual(values, [1, 2])
        q.push(3)
        XCTAssertEqual(values, [1, 2])
    }
    
    func test_contains() {
        let q = Queue<Int>(size: 3)
        q.push(1)
        q.push(2)
        XCTAssert(q.contains(1))
        XCTAssert(q.contains(2))
        XCTAssertFalse(q.contains(3))
    }
    
}
