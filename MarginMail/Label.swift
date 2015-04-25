//
//  Label.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/17/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class Label: Component {

    var text: NSString = "" {
        didSet {
            self.needsUpdate = true
        }
    }
    var font: NSFont? {
        didSet {
            self.needsUpdate = true
        }
    }
    var textColor: NSColor? {
        didSet {
            self.needsUpdate = true
        }
    }

    private var textLayer = TextLayer()

    init() {
        super.init(layer: textLayer)
    }

    override func render() {
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        textLayer.frame = frame
        textLayer.string = text
        textLayer.font = font
        textLayer.foregroundColor = textColor?.CGColor
        CATransaction.commit()
    }

}
