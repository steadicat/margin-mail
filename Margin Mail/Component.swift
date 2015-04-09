//
//  Component.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/6/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
//

import Cocoa

protocol ComponentDelegate {
    func componentRendered(view: NSView)
}

class Component: NSObject {

    var delegate: ComponentDelegate?
    var children: [Component]

    init(children: [Component]) {
        self.children = children
        super.init()
    }
    
    var lastRender: Component?
    var lastView: NSView?
    
    func needsRender() {
        var newRender = self.render()
        var newView: NSView?
        if self.lastRender != nil && newRender.className == self.lastRender!.className {
            newView = newRender.renderToView(self.lastView)
        } else {
            newView = newRender.renderToView(nil)
        }
        self.lastRender = newRender
        self.lastView = newView
        self.delegate?.componentRendered(newView!)
    }
    
    func render() -> Component {
        assert(false, "Components must implement render()")
    }
    
    func renderToView(lastView: NSView?) -> NSView {
        return self.render().renderToView(lastView)
    }
    
    func renderChildren(children: [Component], view: NSView) {
        if children.count + view.subviews.count == 0 {
            return
        }
        
        var viewsToRemove: [NSView] = []
        for i in 0...max(children.count - 1, view.subviews.count - 1) {
            if i >= children.count {
                viewsToRemove.append(view.subviews[i] as! NSView)
            } else if i >= view.subviews.count {
                view.addSubview(children[i].renderToView(nil))
            } else {
                children[i].renderToView(view.subviews[i] as! NSView)
            }
        }
        for view in viewsToRemove {
            view.removeFromSuperview()
        }
    }
    
}
