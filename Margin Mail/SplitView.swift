//
//  SplitView.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/6/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
//

import Cocoa

class SplitView: Component {
    
    var frame: CGRect
    
    init(frame: CGRect, children: [Component]) {
        self.frame = frame
        super.init(children: children)
    }
    
    override func renderToView() -> NSView {
        var view = NSSplitView(frame: self.frame)
        
        view.vertical = true
        
        for child in self.children {
            var renderedView = child.renderToView()
            view.addSubview(renderedView)
        }
        
        return view
    }
    
}
