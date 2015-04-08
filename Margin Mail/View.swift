//
//  View.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/6/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
//

import Cocoa

struct ViewProps {
    var frame: NSRect
    var backgroundColor: NSColor?
}

class View: Component {

    var props: ViewProps

    init(props: ViewProps) {
        self.props = props
        super.init(children: [])
    }

    override func renderToView() -> NSView {
        var view = NSView(frame: self.props.frame)
        if let backgroundColor = self.props.backgroundColor {
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
