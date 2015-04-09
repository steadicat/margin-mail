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
    
    override func render() -> Component {
        return self
    }
    
    override func renderToView(lastView: NSView?, lastRender: Component?) -> NSView {
        var view = lastView != nil ? lastView as! NSSplitView : NSSplitView(frame: self.frame)
        view.frame = self.frame
        
        view.vertical = true
        
        self.renderChildren(view, children: self.children, lastChildren: lastRender != nil ? lastRender!.children : [])
        
        return view
    }
    
}
