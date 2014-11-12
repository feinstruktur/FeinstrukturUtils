//
//  AppInfoTests.swift
//  swift-utils
//
//  Created by Sven Schmidt on 12/11/2014.
//
//

import UIKit
import XCTest


class AppInfoTests: XCTestCase {

    func test_versionString() {
        XCTAssertNotNil(AppInfo.versionString())
    }

}
