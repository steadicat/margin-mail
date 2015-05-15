//
//  DataComponent.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/27/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class DataComponent: Component {

    private var didEverRender = false

    private var stores: [Store] = []

    init(stores: [Store], children: [Component] = [], view: NSView? = nil, layer: CALayer? = nil) {
        super.init(children: children, view: view, layer: layer)
        for store in stores {
            store.addListener(self, callback: self.refreshStore)
        }
    }

    deinit {
        for store in stores {
            store.removeListener(self)
        }
    }

    func onStoreUpdate() {
    }

    override func performUpdate(depth: Int = 0) {
        if !didEverRender {
            onStoreUpdate()
            didEverRender = true
        }
        super.performUpdate(depth: depth)
    }

    private func refreshStore() {
        onStoreUpdate()
        needsUpdate = true
    }
    
}
