//
//  TransportTable.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/18/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import SQLite

class TransportTable: Table {

    var tableName = "transport"

    var query: SQLite.Query {
        return DB.conn[self.tableName]
    }

    let type = Expression<String>("type")
    let hostname = Expression<String>("hostname")
    let port = Expression<Int>("port")
    let username = Expression<String>("username") // TODO: Use keychain
    let password = Expression<String>("password") // TODO: Use keychain

    func create() {
        DB.conn.create(table: self.query, ifNotExists: true) { self.create($0) }
    }

    func create(t: SQLite.SchemaBuilder) {
        t.column(self.type, primaryKey: true)
        t.column(self.hostname)
        t.column(self.port)
        t.column(self.username)
        t.column(self.password)
    }

}
