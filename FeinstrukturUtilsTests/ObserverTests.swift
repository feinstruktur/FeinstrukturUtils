//
//  ObserverTests.swift
//  swift-utils
//
//  Created by Sven Schmidt on 12/11/2014.
//
//

import UIKit
import XCTest
import Nimble


class TestObject: NSObject {
    // dynamic is essential or the notification will not fire
    // see: https://developer.apple.com/library/mac/documentation/Swift/Conceptual/BuildingCocoaApps/AdoptingCocoaDesignPatterns.html
    dynamic var attribute: NSString?
}


class ObserverTests: XCTestCase {

    func test_basic() {
        let obj = TestObject()
        obj.attribute = "foo"
        
        waitUntil { done in
            let obs = Observer(observedObject: obj, keyPath: "attribute") { newValue in
                expect(newValue as? String) == "bar"
                done()
            }
            obj.attribute = "bar"
        }
    }

}
