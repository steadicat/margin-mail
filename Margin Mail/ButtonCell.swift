//
//  ButtonCell.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/10/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
//

import Cocoa

class ButtonCell: NSButtonCell {

    var leftMargin: CGFloat = 0
    var gap: CGFloat = 0

    override func drawImage(image: NSImage, withFrame frame: NSRect, inView controlView: NSView) {
        return super.drawImage(image, withFrame: NSRect(x: frame.origin.x + self.leftMargin, y: frame.origin.y, width: frame.width, height: frame.height), inView: controlView)
    }
    
    override func drawTitle(title: NSAttributedString, withFrame frame: NSRect, inView controlView: NSView) -> NSRect {
        return super.drawTitle(title, withFrame: NSRect(x: frame.origin.x + self.leftMargin + self.gap, y: frame.origin.y, width: frame.width, height: frame.height), inView: controlView)
    }

    override var cellSize: NSSize {
        get {
            var size = super.cellSize
            return NSSize(width: size.width + self.leftMargin + self.gap, height: size.height)
        }
    }
}
