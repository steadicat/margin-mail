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
    
    override func renderToView() -> NSView {
        var view = NSView(frame: self.frame)
        if let backgroundColor = self.backgroundColor {
            view.wantsLayer = true;
            view.layer = CALayer()
            view.layer!.backgroundColor = backgroundColor.CGColor;
        }
        for child in self.children {
            var renderedView = child.renderToView()
            view.addSubview(renderedView)
        }
        return view;
    }
    
}
