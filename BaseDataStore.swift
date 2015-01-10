//
//  BaseDataStore.swift
//
//
//  Created by Sven Schmidt on 14/10/2014.
//  Copyright (c) 2014 Sven A. Schmidt. All rights reserved.
//

import Foundation
import Parse


public enum Environment {
    case Test
    case Production
}


public struct ParseConfig {
    var applicationId: String
    var clientKey: String
}


private var connected = false


public class BaseDataStore {
    
    class func registerSubclasses() {
        assert(false, "override me!")
    }

    class func parseConfig(env: Environment) -> ParseConfig {
        assert(false, "override me!")
        return ParseConfig(applicationId: "", clientKey: "")
    }

    
    public class func connect(env: Environment) {
        if !connected {
            registerSubclasses()
            configureParse(env)
            connected = true
        }
    }
    
    class func configureParse(env: Environment) {
        let config = parseConfig(env)
        Parse.enableLocalDatastore()
        Parse.setApplicationId(config.applicationId, clientKey: config.clientKey)
    }
    
}
