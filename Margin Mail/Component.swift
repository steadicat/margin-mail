//
//  Component.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/6/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
//

import Cocoa

class Component: NSObject {

    var children: [Component]

    init(children: [Component?] = []) {
        self.children = children.filter({$0 != nil}).map({ $0! })
        super.init()
    }

    var dirty = false
    
    func needsRender() {
        if self.dirty {
            return
        }
        self.dirty = true
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.dirty = false
            self.renderSelf()
        })
    }
    
    func render() -> Component {
        assert(false, "Components must implement render()")
    }
    
    func renderToView(lastView: NSView?, lastRender: Component?) -> NSView {
        assert(false, "Only view components can render to view")
    }
    
    
    var lastRender: Component?
    var lastView: NSView?
    
    func renderSelf(var lastRender: Component? = nil) -> NSView {
        if self.lastRender != nil {
            lastRender = self.lastRender
        }
        let lastView = lastRender?.lastView
        
        var newRender = self.render()
        var newView: NSView?
        if newRender.className == lastRender?.className {
            newView = newRender.renderToView(lastView, lastRender: lastRender)
        } else {
            newView = newRender.renderToView(nil, lastRender: nil)
        }
        self.lastRender?.lastRender = nil
        self.lastRender?.lastView = nil
        self.lastRender = newRender
        newRender.lastView = newView
        return newView!
    }
    
    func renderChildren(view: NSView, children: [Component], lastChildren: [Component]) {
        if children.count + lastChildren.count == 0 {
            return
        }
        
        var viewsToRemove: [NSView] = []
        
        for i in 0...max(children.count - 1, lastChildren.count - 1) {
            if i >= children.count && lastChildren[i].lastView != nil {
                viewsToRemove.append(lastChildren[i].lastView!)
            } else if i >= lastChildren.count {
                view.addSubview(children[i].renderSelf())
            } else {
                children[i].renderSelf(lastRender: lastChildren[i].lastRender)
            }
        }
        
        for view in viewsToRemove {
            view.removeFromSuperview()
        }
    }
    
}
