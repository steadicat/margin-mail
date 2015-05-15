//
//  Label.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/17/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class Label: Component {

    var text: NSString = ""
    var font: NSFont?
    var textColor: NSColor?

    private var textLayer = TextLayer()

    init() {
        super.init(layer: textLayer)
    }

    override func render() {
        Layer.withoutAnimations {
            self.textLayer.frame = self.frame
            self.textLayer.string = self.text
            if let font = self.font {
                self.textLayer.font = font
            }
            self.textLayer.foregroundColor = self.textColor?.CGColor
        }
    }

}
