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

    private var registeredStores: [Store] = []
    private let availableStores = Registry().stores

    override init(children: [Component] = [], view: NSView? = nil, layer: CALayer? = nil) {
        super.init(children: children, view: view, layer: layer)

        let stores = getStoresToWatch(availableStores)
        for store in stores {
            store.addListener(self, callback: self.onStoreUpdate)
        }
        registeredStores.extend(stores)
    }

    deinit {
        for store in registeredStores {
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
        getDataFromStores(availableStores)
    }

    func getStoresToWatch(stores: Stores) -> [Store] {
        return []
    }

    func getDataFromStores(stores: Stores) {
        return
    }
    
}
