//
//  Label.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/10/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class Label: TextField {

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
    
}
