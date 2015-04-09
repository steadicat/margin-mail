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
    
    func update(children: [Component]) {
        self.children = children
        self.needsRender()
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
