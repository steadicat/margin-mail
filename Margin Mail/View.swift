//
//  View.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/6/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
//

import Cocoa

class View: Component {

    override func renderToView() -> NSView {
        var view = NSView(frame: self.props["frame"]!.rectValue)
        if let backgroundColor = self.props["backgroundColor"] {
            view.wantsLayer = true;
            view.layer = CALayer()
            view.layer!.backgroundColor = (backgroundColor.nonretainedObjectValue as! NSColor).CGColor;
        }
        for child in self.children {
            var renderedView = child.renderToView()
            view.addSubview(renderedView)
        }
        return view;
    }
    
}
