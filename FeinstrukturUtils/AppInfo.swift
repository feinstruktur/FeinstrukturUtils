//
//  AppInfo.swift
//  Holidays
//
//  Created by Sven Schmidt on 05/09/2014.
//  Copyright (c) 2014 Sven A. Schmidt. All rights reserved.
//

import Foundation

public class AppInfo {
    
    public class func runningTests() -> Bool {
        return (getenv("UNIT_TESTS") != nil)
    }
    
    public class func versionString() -> String? {
        return NSBundle(forClass: self).infoDictionary?["CFBundleVersion"] as? String
    }
    
}