//
//  Label.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/10/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class Label: TextField {
    
    private var _opaque: Bool = false
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        bordered = false
        bezeled = false
        editable = false
        selectable = false
        backgroundColor = nil
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillDraw() {
        super.viewWillDraw()
    }
    
    override var opaque: Bool {
        get {
            return _opaque
        }
        set(value) {
            _opaque = value
        }
    }
    
}
