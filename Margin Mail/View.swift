//
//  View.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/6/15.
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
    
    lazy private var caLayer = CALayer()

    override var flipped: Bool {
        get {
            return true
        }
    }
    
    override func viewWillDraw() {
    
        if let backgroundColor = self.backgroundColor {
            if !self.wantsLayer {
                self.wantsLayer = true;
                self.layer = self.caLayer
            }
            self.layer!.backgroundColor = backgroundColor.CGColor;
        } else {
            self.wantsLayer = false
            self.layer = nil
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
    }
    
    override func mouseExited(theEvent: NSEvent) {
        self.onMouseExit?()
    }
    
    override func mouseDown(theEvent: NSEvent) {
        self.onMouseDown?()
    }
    
    override func mouseUp(theEvent: NSEvent) {
        self.onMouseUp?()
    }
    
    
}
