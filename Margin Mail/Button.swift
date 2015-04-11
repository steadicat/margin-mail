//
//  Button.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/10/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
//

import Cocoa

protocol ButtonDelegate: class {
    func mouseEntered(theEvent: NSEvent)
    func mouseExited(theEvent: NSEvent)
    func mouseDown(theEvent: NSEvent)
    func mouseUp(theEvent: NSEvent)
}

class Button: NSButton {
    
    var text: String = ""
    var textColor: NSColor?
    var backgroundColor: NSColor?
    var gap: CGFloat = 12
    var leftMargin: CGFloat = 0
    
    weak var delegate: ButtonDelegate?
    
    var onMouseDown: (() -> ())?
    var onMouseUp: (() -> ())?
    var onMouseEnter: (() -> ())?
    var onMouseExit: (() -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setCell(PaddedButtonCell())
        self.createTrackingArea()
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
        var cell = self.cell() as! PaddedButtonCell
        cell.highlightsBy = NSCellStyleMask.NoCellMask
        
        cell.backgroundColor = self.backgroundColor
        cell.leftMargin = self.leftMargin

        self.imagePosition = .ImageLeft
        if self.image != nil {
            cell.gap = self.gap
        }
        
        super.viewWillDraw()
    }
    
    private func createTrackingArea() {
        var focusTrackingAreaOptions = NSTrackingAreaOptions.ActiveInActiveApp | NSTrackingAreaOptions.MouseEnteredAndExited | NSTrackingAreaOptions.AssumeInside | NSTrackingAreaOptions.InVisibleRect;
        
        var focusTrackingArea = NSTrackingArea(rect: NSZeroRect, options: focusTrackingAreaOptions, owner: self, userInfo: nil)
        self.addTrackingArea(focusTrackingArea)
    }
    
    override func mouseEntered(theEvent: NSEvent) {
        self.delegate?.mouseEntered(theEvent)
        self.onMouseEnter?()
    }
    
    override func mouseExited(theEvent: NSEvent) {
        self.delegate?.mouseExited(theEvent)
        self.onMouseExit?()
    }
    
    override func mouseDown(theEvent: NSEvent) {
        self.delegate?.mouseDown(theEvent)
        self.onMouseDown?()
    }
    
    override func mouseUp(theEvent: NSEvent) {
        self.delegate?.mouseUp(theEvent)
        self.onMouseUp?()
    }
    
}

