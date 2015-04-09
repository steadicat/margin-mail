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
    
    override func renderToView(lastView: NSView?) -> NSView {
        var view = lastView != nil ? lastView as! NSSplitView : NSSplitView(frame: self.frame)
        view.frame = self.frame
        
        view.vertical = true
        
        self.renderChildren(self.children, view: view)
        
        return view
    }
    
}
