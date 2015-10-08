//
//  String+utils.swift
//  swift-utils
//
//  Created by Sven Schmidt on 25/11/2014.
//
//

import Foundation


extension String {
    
    public func split() -> [String] {
        return self.split(" \t,")
    }
 
    
    public func split(separators: String) -> [String] {
        let separators = NSCharacterSet(charactersInString: separators)
        let parts = self.componentsSeparatedByCharactersInSet(separators)
        return parts.filter { $0.characters.count > 0 }
    }
    
    
    public func urlEncode() -> String? {
        let allowed = NSCharacterSet(charactersInString: "!*'();:@&=+$,/?")
        return self.stringByAddingPercentEncodingWithAllowedCharacters(allowed)
    }


    public func contains(find: String) -> Bool{
        return self.rangeOfString(find) != nil
    }

}
