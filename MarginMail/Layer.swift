//
//  Layer.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 5/14/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class Layer {

    static func withoutAnimations(@noescape block: () -> Void) {
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        block()
        CATransaction.commit()
    }
    
}
