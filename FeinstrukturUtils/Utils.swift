//
//  Utils.swift
//  Fradio
//
//  Created by Sven A. Schmidt on 19/03/2015.
//  Copyright (c) 2015 feinstruktur. All rights reserved.
//

import UIKit


public func showAlertWithMessage(message: String) {
    let alert = UIAlertView(title: "Error", message: message, delegate: nil, cancelButtonTitle: "Damn!")
    alert.show()
}


public func showAlertWithError(error: NSError) {
    showAlertWithMessage("Well, that didn't work: \(error.localizedDescription)")
}


extension UITextView {
    
    public func append(text: String) {
        let current = self.text
        if current == "" {
            self.text = text
        } else {
            self.text = text + "\n" + current
        }
    }
    
}


