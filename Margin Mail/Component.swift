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
    
    var dirty = false
    
    func needsRender() {
        if self.dirty {
            return
        }
        self.dirty = true
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.dirty = false
            var newRender = self.render()
            var newView: NSView?
            if self.lastRender != nil && newRender.className == self.lastRender!.className {
                newView = newRender.renderToView(self.lastView, lastRender: self.lastRender)
            } else {
                newView = newRender.renderToView(nil, lastRender: nil)
            }
            self.lastRender = newRender
            newRender.lastView = newView
            if (newView != self.lastView) {
                self.lastView = newView
                self.delegate?.componentRendered(newView!)
            }
        })
    }
    
    func render() -> Component {
        assert(false, "Components must implement render()")
    }
    
    func renderToView(lastView: NSView?, lastRender: Component?) -> NSView {
        assert(false, "Only view components can render to view")
        var view = self.render().renderToView(lastView, lastRender: lastRender);
        self.lastView = view
        return view
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
                var render = children[i].render()
                children[i].lastRender = render;
                render.lastView = render.renderToView(nil, lastRender: nil)
                view.addSubview(render.lastView!)
            } else {
                var render = children[i].render()
                children[i].lastRender = render
                render.lastView = render.renderToView(lastChildren[i].lastRender!.lastView, lastRender: lastChildren[i].lastRender)
            }
        }
        for view in viewsToRemove {
            view.removeFromSuperview()
        }
    }
    
}
