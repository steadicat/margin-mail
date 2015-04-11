//
//  DelegatingButton.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/10/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
//

import Cocoa

protocol DelegatingButtonDelegate {
    func mouseEntered(theEvent: NSEvent)
    func mouseExited(theEvent: NSEvent)
    func mouseDown(theEvent: NSEvent)
    func mouseUp(theEvent: NSEvent)
}

class DelegatingButton: NSButton {

    var delegate: DelegatingButtonDelegate?
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.createTrackingArea()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.createTrackingArea()
    }
    
    private func createTrackingArea() {
        var focusTrackingAreaOptions = NSTrackingAreaOptions.ActiveInActiveApp | NSTrackingAreaOptions.MouseEnteredAndExited | NSTrackingAreaOptions.AssumeInside | NSTrackingAreaOptions.InVisibleRect;
        
        var focusTrackingArea = NSTrackingArea(rect: NSZeroRect, options: focusTrackingAreaOptions, owner: self, userInfo: nil)
        self.addTrackingArea(focusTrackingArea)
    }
    
    override func mouseEntered(theEvent: NSEvent) {
        self.delegate?.mouseEntered(theEvent)
    }
    
    override func mouseExited(theEvent: NSEvent) {
        self.delegate?.mouseExited(theEvent)
    }
    
    override func mouseDown(theEvent: NSEvent) {
        self.delegate?.mouseDown(theEvent)
    }
    
    override func mouseUp(theEvent: NSEvent) {
        self.delegate?.mouseUp(theEvent)
    }
    
}
