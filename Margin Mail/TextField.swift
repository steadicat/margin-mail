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
    
    init(frame: CGRect, text: String = "", children: [Component] = []) {
        self.frame = frame
        self.text = text
        super.init(children: children)
    }
    
    override func render() -> Component {
        return self
    }
    
    override func renderToView(lastView: NSView?, lastRender: Component?) -> NSView {
        var view = lastView != nil ? lastView as! NSTextField : NSTextField(frame: self.frame)
        view.frame = self.frame
        
        if lastRender == nil || (lastRender as! TextField).text != self.text {
            view.stringValue = self.text
        }
        
        self.renderChildren(view, children: self.children, lastChildren: lastRender != nil ? lastRender!.children : [])
        
        return view
    }
    
}
