//
//  LabelComponent.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/10/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
//

import Cocoa

class LabelComponent: Component {

    let frame: CGRect
    let textColor: NSColor?
    let font: NSFont?
    let text: String
    
    init(frame: CGRect, text: String, textColor: NSColor? = nil, font: NSFont? = nil) {
        self.frame = frame
        self.textColor = textColor
        self.font = font
        self.text = text
    }
    
    override func render() -> Component {
        return TextField(
            frame: self.frame,
            text: self.text,
            bordered: false,
            bezeled: false,
            editable: false,
            selectable: false,
            textColor: self.textColor,
            backgroundColor: nil,
            font: self.font
        )
    }
}
