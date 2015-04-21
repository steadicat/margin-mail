//
//  Label.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/17/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class Label: NSView {

    var text: NSString = "" {
        didSet {
            self.needsDisplay = true
        }
    }
    var font: NSFont? {
        didSet {
            self.needsDisplay = true
        }
    }
    var textColor: NSColor? {
        didSet {
            self.needsDisplay = true
        }
    }

    private func getAttributes() -> [String: AnyObject] {
        return [
            NSFontAttributeName as String: font ?? NSFont.systemFontOfSize(NSFont.systemFontSize()),
            NSForegroundColorAttributeName as String: textColor ?? NSColor.blackColor()
        ]
    }

    override func drawRect(dirtyRect: NSRect) {
        text.drawInRect(bounds, withAttributes: getAttributes())
    }

    func sizeToFit() {
        frame = CGRect(origin: frame.origin, size: text.sizeWithAttributes(getAttributes()))
    }

}
