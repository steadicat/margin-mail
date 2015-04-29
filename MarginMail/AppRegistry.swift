//
//  AppRegistry.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/24/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

@inline(__always) func Registry() -> AppRegistry {
    return AppRegistry.sharedInstance
}

@inline(__always) func Actions() -> MainActions {
    return Registry().actions
}

@inline(__always) func Stores() -> MainStores {
    return Registry().stores
}

class AppRegistry {

    static let sharedInstance = AppRegistry()

    let actions: MainActions
    let stores: MainStores

    init() {
        let db = Database(Env.dataPathForName("db.sqlite3"))
        let dispatcher = Dispatcher()

        actions = MainActions(dispatcher)
        stores = MainStores(
            account: AccountStore(dispatcher, db: db),
            message: MessageStore(dispatcher),
            navigation: NavigationStore(dispatcher)
        )
    }

}