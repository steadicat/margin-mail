//
//  View.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/6/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
//

import Cocoa

class View: Component {

    var frame: CGRect
    var backgroundColor: NSColor?
    
    init(frame: CGRect, backgroundColor: NSColor? = nil, children: [Component?] = []) {
        self.frame = frame
        self.backgroundColor = backgroundColor
        super.init(children: children)
    }
    
    override func render() -> Component {
        return self
    }
    
    override func renderToView(lastView: NSView?, lastRender: Component?) -> NSView {
        var view = lastView != nil ? lastView! : NSView(frame: self.frame)
        view.frame = self.frame
        
        if let backgroundColor = self.backgroundColor {
            view.wantsLayer = true;
            view.layer = CALayer()
            view.layer!.backgroundColor = backgroundColor.CGColor;
        }

        self.renderChildren(view, children: self.children, lastChildren: lastRender != nil ? lastRender!.children : [])

        return view;
    }
    
}
