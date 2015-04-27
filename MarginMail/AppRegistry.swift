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

class AppRegistry {

    static let sharedInstance = AppRegistry()

    let actions: Actions
    let stores: Stores

    init() {
        let database = Database(Env.dataPathForName("db.sqlite3"))
        let dispatcher = AppDispatcher()

        actions = Actions(dispatcher)
        stores = Stores(dispatcher, database)
    }

}