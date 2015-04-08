//
//  SplitView.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/6/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
//

import Cocoa

struct SplitViewProps {
    var frame: NSRect
}

class SplitView: Component {

    var props: SplitViewProps

    init(props: SplitViewProps, children: [Component]) {
        self.props = props
        super.init(children: children)
    }
    
    override func renderToView() -> NSView {
        var view = NSSplitView(frame: self.props.frame)
        
        view.vertical = true
        
        for child in self.children {
            var renderedView = child.renderToView()
            view.addSubview(renderedView)
        }
        
        return view;
    }
    
}
