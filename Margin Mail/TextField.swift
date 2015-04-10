//
//  TextField.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/8/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
//

import Cocoa

class TextField: Component {
    
    var frame: CGRect
    var text: String
    var textColor: NSColor
    var backgroundColor: NSColor?
    var bordered: Bool
    var bezeled: Bool
    var editable: Bool
    var selectable: Bool
    var font: NSFont
    
    init(
        frame: CGRect,
        text: String = "",
        textColor: NSColor? = nil,
        backgroundColor: NSColor? = NSColor.whiteColor(),
        bordered: Bool? = nil,
        bezeled: Bool? = nil,
        editable: Bool? = nil,
        selectable: Bool? = nil,
        font: NSFont? = nil,
        children: [Component?] = []) {
            self.frame = frame
            self.text = text
            self.textColor = textColor ?? NSColor.blackColor()
            self.backgroundColor = backgroundColor
            self.bordered = bordered ?? true
            self.bezeled = bezeled ?? true
            self.editable = editable ?? true
            self.selectable = selectable ?? true
            self.font = font ?? NSFont.systemFontOfSize(NSFont.systemFontSize())
            super.init(children: children)
    }
    
    override func render() -> Component {
        return self
    }
    
    override func renderToView(lastView: NSView?, lastRender: Component?) -> NSView {
        var view = lastView != nil ? lastView as! NSTextField : NSTextField(frame: self.frame)
        if self.frame != (self.lastRender as? TextField)?.frame {
            view.frame = self.frame
        }
        
        if self.text != (lastRender as? TextField)?.text {
            view.stringValue = self.text
        }
        
        view.textColor = self.textColor
        view.drawsBackground = self.backgroundColor != nil
        view.backgroundColor = self.backgroundColor
        view.bordered = self.bordered
        view.bezeled = self.bezeled
        view.editable = self.editable
        view.selectable = self.selectable
        view.font = font
        
        self.renderChildren(view, children: self.children, lastChildren: lastRender != nil ? lastRender!.children : [])
        
        return view
    }
    
}
