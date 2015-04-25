//
//  Component.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/22/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class Component: NSObject {

    var frame: CGRect = CGRectZero {
        didSet {
            self.render()
        }
    }

    var bounds: CGRect {
        get {
            return Rect(0, 0, frame.width, frame.height)
        }
    }

    var children: [Component]
    var view: NSView?

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

    init(children: [Component] = [], view: NSView? = nil) {
        self.children = children
        self.view = view

        super.init()

        if let view = self.view {
            for child in children {
                if let subview = child.view {
                    view.addSubview(subview)
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