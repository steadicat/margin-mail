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

    let config: Config
    let actions: Actions
    let stores: Stores

    init() {
        self.config = Config()
        
        let dispatcher = AppDispatcher()
        self.actions = Actions(dispatcher)
        
        let db = Database(name: "db.sqlite3", url: config.dataURL)
        self.stores = Stores(dispatcher, db)
    }

}