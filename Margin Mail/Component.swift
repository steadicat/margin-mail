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

    /*
    var _props: [String: NSValue]
    var props: [String: NSValue] {
        get {
            return self._props
        }
        set(newProps) {
            self._props = newProps
            self.needsRender()
        }
    }
    */
    
    var children: [Component]

    init(children: [Component]) {
        self.children = children
    }

    override convenience init() {
        self.init(children: [])
    }
    
    func needsRender() {
        var view = self.renderToView()
        self.delegate?.componentRendered(view)
    }
    
    func render() -> Component {
        assert(false, "Components must implement render()")
    }
    
    func renderToView() -> NSView {
        return self.render().renderToView()
    }
    
}
