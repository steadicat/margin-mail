//
//  MailboxTable.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/18/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa
import SQLite

class MailboxTable: Table {

    var tableName = "mailbox"

    var query: SQLite.Query {
        return DB.conn[self.tableName]
    }

    let id = SQLite.Expression<NSUUID>("id")
    let name = SQLite.Expression<String>("name")
    let photo = SQLite.Expression<NSImage?>("photo")

    func create() {
        DB.conn.create(table: self.query, ifNotExists: true) { self.create($0) }
    }

    func create(t: SQLite.SchemaBuilder) {
        t.column(self.id, primaryKey: true)
        t.column(self.name)
        t.column(self.photo)
    }

}
