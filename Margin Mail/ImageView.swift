//
//  ImageView.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/11/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class ImageView: NSImageView {
    
    private var _opaque: Bool = true
    
    override var opaque: Bool {
        get {
            return _opaque
        }
        set(value) {
            _opaque = value
        }
    }
    
}
