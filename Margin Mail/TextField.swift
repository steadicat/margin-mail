//
//  TextField.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/8/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
//

import Cocoa

class TextField: NSTextField {
    
    var text: String = "" {
        didSet {
            self.stringValue = self.text
        }
    }
    
}
