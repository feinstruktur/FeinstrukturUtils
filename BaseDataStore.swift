//
//  BaseDataStore.swift
//
//
//  Created by Sven Schmidt on 14/10/2014.
//  Copyright (c) 2014 Sven A. Schmidt. All rights reserved.
//

import Foundation
import Parse


enum Environment {
    case Test
    case Production
}


struct ParseConfig {
    var applicationId: String
    var clientKey: String
}


class BaseDataStore {
    
    class func registerSubclasses() {
        assert(false, "override me!")
    }

    class func parseConfig(env: Environment) -> ParseConfig {
        assert(false, "override me!")
        return ParseConfig(applicationId: "", clientKey: "")
    }

    class func connect(env: Environment) {
        registerSubclasses()
        configureParse(env)
    }
    
    class func configureParse(env: Environment) {
        let config = parseConfig(env)
        Parse.setApplicationId(config.applicationId, clientKey: config.clientKey)
    }
    
}
