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
    
}
