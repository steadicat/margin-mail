//
//  Button.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/10/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
//

import Cocoa

class Button: Component {
    
    private let frame: CGRect
    private let text: String
    private let textColor: NSColor?
    private let backgroundColor: NSColor?
    private let bordered: Bool
    private let font: NSFont?
    private let image: NSImage?
    
    let onClick: (() -> ())?
    
    init(
        frame: CGRect,
        text: String = "",
        textColor: NSColor? = nil,
        backgroundColor: NSColor? = NSColor.whiteColor(),
        bordered: Bool? = nil,
        font: NSFont? = nil,
        image: NSImage? = nil,
        onClick: (() -> ())? = nil,
        children: [Component?] = []
        ) {
            self.frame = frame
            self.text = text
            self.textColor = textColor
            self.backgroundColor = backgroundColor
            self.bordered = bordered ?? true
            self.font = font
            self.image = image
            self.onClick = onClick
            super.init(children: children)
    }
    
    override func render() -> Component {
        return self
    }
    
    override func renderToView(lastView: NSView?, lastRender: Component?) -> NSView {
        var view = lastView != nil ? lastView as! NSButton : NSButton(frame: self.frame)
        
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

        view.image = self.image
        if self.image != nil {
            cell.gap = 12
        }
        
        view.imagePosition = .ImageLeft
        
        self.renderChildren(view, children: self.children, lastChildren: lastRender != nil ? lastRender!.children : [])
        
        view.target = self
        view.action = Selector("onMouseDown")
        view.sendActionOn(Int(NSEventMask.LeftMouseDownMask.rawValue))
        
        return view
    }
    
    func onMouseDown() {
        onClick?()
    }
    
}

