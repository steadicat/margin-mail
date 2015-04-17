//
//  View.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/17/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class View: NSView {

    var backgroundColor: NSColor? {
        didSet {
            self.needsDisplay = true
        }
    }

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

    override var flipped: Bool {
        get {
            return true
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

    override func viewWillDraw() {

        if let backgroundColor = self.backgroundColor {
            self.wantsLayer = true
            self.layer!.backgroundColor = backgroundColor.CGColor;
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
