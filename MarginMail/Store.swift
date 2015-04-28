//
//  Store.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/26/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

struct Stores {

    let account: AccountStore
    let message: MessageStore

    init(_ dispatcher: Dispatcher, _ database: Database) {
        account = AccountStore(dispatcher, database: database)
        message = MessageStore(dispatcher, database: database)
    }

}

class Store {

    private let notifier = Notifier()

    let database: Database

    init(_ dispatcher: Dispatcher, database: Database) {
        self.database = database
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