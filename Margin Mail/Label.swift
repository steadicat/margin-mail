//
//  Label.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/10/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
//

import Cocoa

class Label: TextField {

    override func viewWillDraw() {
        bordered = false
        bezeled = false
        editable = false
        selectable = false
        backgroundColor = nil

        super.viewWillDraw()
    }
    
}
