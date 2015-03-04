//
//  CoreGraphicsTests.swift
//  swift-utils
//
//  Created by Sven Schmidt on 04/03/2015.
//
//

import UIKit
import XCTest
import Nimble


class CoreGraphicsTests: XCTestCase {

    func testAddition() {
        expect(CGPoint(x: 1, y: 2) + CGPoint(x: 2, y: 3)) == CGPoint(x: 3, y: 5)
    }
    
}
