//
//  TextLayer.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/20/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class TextLayer: CATextLayer {

    override init!(layer: AnyObject!) {
        super.init(layer: layer)
    }

    override var font: AnyObject! {
        get {
            return super.font
        }
        set(font) {
            super.font = font
            super.fontSize = (font as! NSFont).pointSize
        }
    }

    override init() {
        super.init()
        contentsScale = NSScreen.mainScreen()!.backingScaleFactor
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var lineHeight: CGFloat {
        get {
            return (font as! NSFont).boundingRectForFont.height
        }
    }

}
