//
//  Store.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/26/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

struct Stores {

    let account: AccountStore

    init(_ dispatcher: Dispatcher, _ db: Database) {
        account = AccountStore(dispatcher, db: db)
    }

}

class Store {

    private let notifier: Notifier

    let db: Database

    init(_ dispatcher: Dispatcher, db: Database) {
        notifier = Notifier()
        self.db = db
        dispatcher.register(self.handleAction)
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