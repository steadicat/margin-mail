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

    init(props: [String: NSValue]) {
        self._props = props
        super.init()
    }
    
    func needsRender() {
        var view = self.render()
        self.delegate?.componentRendered(view)
    }
    
    func render() -> NSView {
        assert(false, "Components must implement render()")
    }
    
}
