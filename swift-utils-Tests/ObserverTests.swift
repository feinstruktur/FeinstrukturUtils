//
//  ObserverTests.swift
//  swift-utils
//
//  Created by Sven Schmidt on 12/11/2014.
//
//

import UIKit
import XCTest


class TestObject: NSObject {
    // dynamic is essential or the notification will not fire
    // see: https://developer.apple.com/library/mac/documentation/Swift/Conceptual/BuildingCocoaApps/AdoptingCocoaDesignPatterns.html
    dynamic var attribute: NSString?
}


class ObserverTests: XCTestCase {

    func test_init() {
        let obj = TestObject()
        obj.attribute = "foo"
        
        let exp = self.expectationWithDescription("")
        let obs = Observer(observedObject: obj, keyPath: "attribute") {
            exp.fulfill()
        }
        obj.attribute = "bar"
        self.waitForExpectationsWithTimeout(5, handler: nil)
    }

}
