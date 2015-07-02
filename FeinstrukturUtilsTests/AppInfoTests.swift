//
//  AppInfoTests.swift
//  swift-utils
//
//  Created by Sven Schmidt on 12/11/2014.
//
//

import XCTest
import Nimble


class AppInfoTests: XCTestCase {

    func test_versionString() {
        expect(AppInfo.versionString()).toNot(beNil())
    }

}
