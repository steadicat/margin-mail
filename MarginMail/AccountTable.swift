//
//  AccountTable.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/18/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa
import SQLite

class AccountTable: Table {

    static let id = SQLite.Expression<NSUUID>("id")
    static let name = SQLite.Expression<String>("name")
    static let email = SQLite.Expression<String>("email")
    static let photo = SQLite.Expression<NSImage?>("photo")

    static func query() -> SQLite.Query {
        return DB.conn["account"]
    }

    static func all() -> SQLite.Query {
        return query()
    }
    
    static func create() {
        DB.conn.create(table: query()) { t in
            t.column(self.id, primaryKey: true, defaultValue: DB.Func.uuid)
            t.column(self.name)
            t.column(self.email)
            t.column(self.photo)
        }
    }

}
