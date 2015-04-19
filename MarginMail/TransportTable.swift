//
//  TransportTable.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/18/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import SQLite

class TransportTable: Table {

    static let type = Expression<String>("type")
    static let hostname = Expression<String>("hostname")
    static let port = Expression<Int>("port")
    static let username = Expression<String>("username") // TODO: Use keychain
    static let password = Expression<String>("password") // TODO: Use keychain

    static func all() -> SQLite.Query {
        return DB.conn["transport"]
    }

    static func create() {
        DB.conn.create(table: all()) { t in
            t.column(self.type, primaryKey: true)
            t.column(self.hostname)
            t.column(self.port)
            t.column(self.username)
            t.column(self.password)
        }
    }

}
