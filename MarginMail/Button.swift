//
//  Button.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/17/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class Button: NSButton {

    var text: String = ""
    var textColor: NSColor?
    var backgroundColor: NSColor?
    var gap: CGFloat = 12
    var leftMargin: CGFloat = 0

    var onMouseDown: (() -> ())? {
        didSet {
            self.createTrackingArea()
        }
    }
    var onMouseUp: (() -> ())? {
        didSet {
            self.createTrackingArea()
        }
    }
    var onMouseEnter: (() -> ())? {
        didSet {
            self.createTrackingArea()
        }
    }
    var onMouseExit: (() -> ())? {
        didSet {
            self.createTrackingArea()
        }
    }

    private var _opaque: Bool = true

    override var opaque: Bool {
        get {
            return _opaque
        }
        set(value) {
            _opaque = value
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setCell(ButtonCell())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillDraw() {
        var title = NSMutableAttributedString(string: self.text)
        var range = NSMakeRange(0, title.length)
        if let textColor = self.textColor {
            title.addAttribute(NSForegroundColorAttributeName, value: textColor, range: range)
            title.fixAttributesInRange(range)
        }
        if let font = self.font {
            title.addAttribute(NSFontAttributeName, value: font, range: range)
        }
        self.attributedTitle = title

        // Remove the highlight on click
        var cell = self.cell() as! ButtonCell
        cell.highlightsBy = NSCellStyleMask.NoCellMask

        cell.backgroundColor = self.backgroundColor
        cell.leftMargin = self.leftMargin

        self.imagePosition = .ImageLeft
        if self.image != nil {
            cell.gap = self.gap
        }

        super.viewWillDraw()
    }

    private var focusTrackingArea: NSTrackingArea?

    private func createTrackingArea() {
        if focusTrackingArea != nil {
            return
        }

        var focusTrackingAreaOptions = NSTrackingAreaOptions.ActiveInActiveApp | NSTrackingAreaOptions.MouseEnteredAndExited | NSTrackingAreaOptions.AssumeInside | NSTrackingAreaOptions.InVisibleRect;

        focusTrackingArea = NSTrackingArea(rect: NSZeroRect, options: focusTrackingAreaOptions, owner: self, userInfo: nil)
        self.addTrackingArea(focusTrackingArea!)
    }

    override func mouseEntered(theEvent: NSEvent) {
        self.onMouseEnter?()
        super.mouseEntered(theEvent)
    }

    override func mouseExited(theEvent: NSEvent) {
        self.onMouseExit?()
        super.mouseExited(theEvent)
    }

    override func mouseDown(theEvent: NSEvent) {
        self.onMouseDown?()
        super.mouseDown(theEvent)
    }

    override func mouseUp(theEvent: NSEvent) {
        self.onMouseUp?()
        super.mouseUp(theEvent)
    }
    
}
