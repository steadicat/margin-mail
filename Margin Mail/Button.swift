//
//  Button.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/10/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
//

import Cocoa

class Button: Component, DelegatingButtonDelegate {
    
    private let frame: CGRect
    private let text: String
    private let textColor: NSColor?
    private let backgroundColor: NSColor?
    private let bordered: Bool
    private let font: NSFont?
    private let image: NSImage?
    private let gap: CGFloat
    private let leftMargin: CGFloat
    
    private var onMouseDown: (() -> ())?
    private var onMouseUp: (() -> ())?
    private var onMouseEnter: (() -> ())?
    private var onMouseExit: (() -> ())?
    
    init(
        frame: CGRect,
        text: String = "",
        textColor: NSColor? = nil,
        backgroundColor: NSColor? = NSColor.whiteColor(),
        bordered: Bool? = nil,
        font: NSFont? = nil,
        image: NSImage? = nil,
        gap: CGFloat? = nil,
        leftMargin: CGFloat? = nil,
        onMouseDown: (() -> ())? = nil,
        onMouseUp: (() -> ())? = nil,
        onMouseEnter: (() -> ())? = nil,
        onMouseExit: (() -> ())? = nil,
        children: [Component?] = []
        ) {
            self.frame = frame
            self.text = text
            self.textColor = textColor
            self.backgroundColor = backgroundColor
            self.bordered = bordered ?? true
            self.font = font
            self.image = image
            self.gap = gap ?? 12
            self.leftMargin = leftMargin ?? 0
            self.onMouseDown = onMouseDown
            self.onMouseUp = onMouseUp
            self.onMouseEnter = onMouseEnter
            self.onMouseExit = onMouseExit
            super.init(children: children)
    }
    
    override func render() -> Component {
        return self
    }
    
    override func renderToView(lastView: NSView?, lastRender: Component?) -> NSView {
        var view = lastView != nil ? lastView as! DelegatingButton : DelegatingButton(frame: self.frame)
        view.delegate = self
        
        if lastView == nil {
            view.setCell(PaddedButtonCell())
        }
        
        if self.frame != (self.lastRender as? Button)?.frame {
            view.frame = self.frame
        }
        
        var title = NSMutableAttributedString(string: self.text)
        var range = NSMakeRange(0, title.length)
        if let textColor = self.textColor {
            title.addAttribute(NSForegroundColorAttributeName, value: textColor, range: range)
            title.fixAttributesInRange(range)
        }
        if let font = self.font {
            title.addAttribute(NSFontAttributeName, value: font, range: range)
        }
        view.attributedTitle = title

        view.bordered = self.bordered
        
        // Remove the highlight on click
        var cell = view.cell() as! PaddedButtonCell
        cell.highlightsBy = NSCellStyleMask.NoCellMask
        
        cell.backgroundColor = self.backgroundColor
        cell.leftMargin = self.leftMargin

        view.image = self.image
        view.imagePosition = .ImageLeft
        if self.image != nil {
            cell.gap = self.gap
        }
        
        self.renderChildren(view, children: self.children, lastChildren: lastRender != nil ? lastRender!.children : [])
        
        return view
    }
    
    func mouseEntered(theEvent: NSEvent) {
        self.onMouseEnter?()
    }
    
    func mouseExited(theEvent: NSEvent) {
        self.onMouseExit?()
    }
    
    func mouseDown(theEvent: NSEvent) {
        self.onMouseDown?()
    }
    
    func mouseUp(theEvent: NSEvent) {
        self.onMouseUp?()
    }
    
}

