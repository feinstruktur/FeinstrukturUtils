//
//  AppInfo.swift
//  Holidays
//
//  Created by Sven Schmidt on 05/09/2014.
//  Copyright (c) 2014 Sven A. Schmidt. All rights reserved.
//

import Foundation

class AppInfo {
    
    class func runningTests() -> Bool {
        return (getenv("UNIT_TESTS") != nil)
    }
    
}