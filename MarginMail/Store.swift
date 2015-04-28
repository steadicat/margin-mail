//
//  Store.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/27/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

class Store {

    private let notifier = Notifier()

    init(_ dispatcher: Dispatcher) {
        dispatcher.register(handleAction)
    }

    func handleAction(action: Action) {
        // Override in subclassed store. Will handle all actions created by any
        // dispatchers bound to this store.
    }

    func notify() {
        notifier.notifyListeners()
    }

    func addListener(context: AnyObject, callback: Void -> Void) {
        notifier.addListener(context, callback: callback)
    }

    func removeListener(context: AnyObject) {
        notifier.removeListener(context)
    }
    
}