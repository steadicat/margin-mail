//
//  Component.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/22/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class Component {

    var frame: CGRect = CGRectZero {
        didSet {
            needsUpdate = true
        }
    }

    var bounds: CGRect {
        get {
            return Rect(0, 0, frame.width, frame.height)
        }
    }

    var key: String = ""
    var children: [Component]
    var view: NSView?
    var layer: CALayer?

    var needsUpdate: Bool = true {
        didSet {
            if !updateDispatched {
                updateDispatched = true
                dispatch_async(dispatch_get_main_queue()) { [weak self] in
                    self?.performUpdate()
                }
            }
        }
    }

    private var updateDispatched = false

    init(children: [Component] = [], view: NSView? = nil, layer: CALayer? = nil) {
        self.children = children
        self.view = view
        self.layer = layer ?? view?.layer

        if let view = self.view {
            for child in children {
                if let subview = child.view {
                    assert(view != subview, "Components should not own a view that belongs to one of their children")
                    view.addSubview(subview)
                }
            }
        } else if children.count == 1 {
            self.view = children[0].view
        }

        if let layer = self.layer {
            for child in children {
                if let sublayer = child.layer {
                    assert(layer != sublayer, "Components should not own a layer that belongs to one of their children")
                    layer.addSublayer(sublayer)
                }
            }
        }

    }

    private func performUpdate() {
        self.render()
        for child in children {
            child.render()
        }
        needsUpdate = false
        updateDispatched = false
    }

    func render() {
        assertionFailure("Components must implement render()")
    }

}