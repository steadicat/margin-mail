//
//  Component.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/22/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

let mutex = NSLock()

class Component {

    var key: String = ""

    var view: NSView?
    var layer: CALayer?

    var frame: CGRect = CGRectZero {
        didSet {
            needsUpdate = true
        }
    }

    var bounds: CGRect {
        return Rect(0, 0, frame.width, frame.height)
    }

    var children: [Component] = [] {
        willSet {
            detachChildren()
        }
        didSet {
            attachChildren()
            needsUpdate = true
        }
    }

    var needsUpdate: Bool = true {
        didSet {
            self.scheduleUpdate()
        }
    }

    private var updateDispatched = false

    init(children: [Component] = [], view: NSView? = nil, layer: CALayer? = nil) {
        self.children = children
        self.view = view
        self.layer = layer ?? view?.layer

        attachChildren()
    }

    func render() {
        // Override in subclassed component.
    }

    private func scheduleUpdate() {
        Lock.with(mutex) {
            if (!self.updateDispatched) {
                self.updateDispatched = true
                Dispatch.main(self.performUpdate)
            }
        }
    }

    private func performUpdate() {
        for child in children {
            child.render()
        }
        render()
        needsUpdate = false
        updateDispatched = false
    }

    private func attachChildren() {
        if let view = view {
            for child in children {
                if let subview = child.view {
                    assert(view != subview, "Components should not own a view that belongs to one of their children")
                    view.addSubview(subview)
                } else if child.children.count == 1 {
                    // TODO: make this recursive
                    if let childSubview = child.children[0].view {
                        view.addSubview(childSubview)
                    }
                }
            }
        } else if children.count == 1 {
            view = children[0].view
        }

        if let layer = layer {
            for child in children {
                if let sublayer = child.layer {
                    assert(layer != sublayer, "Components should not own a layer that belongs to one of their children")
                    layer.addSublayer(sublayer)
                }
            }
        }
    }

    private func detachChildren() {
        for child in children {
            child.view?.removeFromSuperview()
        }
    }

}