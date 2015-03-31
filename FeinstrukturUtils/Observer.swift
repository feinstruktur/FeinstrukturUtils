//
//  Observer.swift
//  swift-utils
//
//  Created by Sven Schmidt on 12/11/2014.
//
//

import Foundation


public class Observer: NSObject {
    
    var observedObject: NSObject
    var keyPath: String
    var block: AnyObject? -> Void
    
    
    public init(observedObject: NSObject, keyPath: String, block: AnyObject? -> Void) {
        self.observedObject = observedObject
        self.keyPath = keyPath
        self.block = block
        super.init()
        self.observedObject.addObserver(self, forKeyPath: self.keyPath, options: .New, context: nil)
    }
    
    
    deinit {
        self.observedObject.removeObserver(self, forKeyPath: self.keyPath)
    }
    
    
    public override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        if keyPath == self.keyPath {
            let newValue: AnyObject? = change[NSKeyValueChangeNewKey]
            self.block(newValue)
        }
    }
    
}