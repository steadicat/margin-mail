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
    
    init(frame: CGRect, backgroundColor: NSColor?, children: [Component]) {
        self.frame = frame
        self.backgroundColor = backgroundColor
        super.init(children: children)
    }
    
    override func renderToView(lastView: NSView?) -> NSView {
        var view = lastView != nil ? lastView! : NSView(frame: self.frame)
        view.frame = self.frame
        
        if let backgroundColor = self.backgroundColor {
            view.wantsLayer = true;
            view.layer = CALayer()
            view.layer!.backgroundColor = backgroundColor.CGColor;
        }

        self.renderChildren(self.children, view: view)

        return view;
    }
    
}
