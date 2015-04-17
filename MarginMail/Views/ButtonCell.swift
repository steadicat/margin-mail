//
//  ButtonCell.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/17/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class ButtonCell: NSButtonCell {

    var leftMargin: CGFloat = 0
    var gap: CGFloat = 0

    override func drawImage(image: NSImage, withFrame frame: CGRect, inView controlView: NSView) {
        return super.drawImage(image, withFrame: CGRect(x: frame.origin.x + self.leftMargin, y: frame.origin.y, width: frame.width, height: frame.height), inView: controlView)
    }

    override func drawTitle(title: NSAttributedString, withFrame frame: CGRect, inView controlView: NSView) -> CGRect {
        return super.drawTitle(title, withFrame: CGRect(x: frame.origin.x + self.leftMargin + self.gap, y: frame.origin.y, width: frame.width, height: frame.height), inView: controlView)
    }

    override var cellSize: NSSize {
        get {
            var size = super.cellSize
            return NSSize(width: size.width + self.leftMargin + self.gap, height: size.height)
        }
    }
}
