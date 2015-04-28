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

    override init(children: [Component] = [], view: NSView? = nil, layer: CALayer? = nil) {
        super.init(children: children, view: view, layer: layer)

        stores = getStoresToWatch()
        for store in stores {
            store.addListener(self, callback: self.onStoreUpdate)
        }
    }

    deinit {
        for store in stores {
            store.removeListener(self)
        }
    }

    override func performUpdate() {
        if !didEverRender {
            onStoreUpdate()
            didEverRender = true
        }
        super.performUpdate()
    }

    private func onStoreUpdate() {
        getDataFromStores()
    }

    func getStoresToWatch() -> [Store] {
        return []
    }

    func getDataFromStores() {
        return
    }
    
}
