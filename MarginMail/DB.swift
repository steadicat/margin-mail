//
//  DB.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/17/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import SQLite


class DB {

    static let filename = "db.sqlite3"

    static let tables: [Table] = [
        TransportTable(),
        MailboxTable(),
    ]

    static var path: String = {
        return Config.dataURL.URLByAppendingPathComponent(DB.filename).path!
    }()

    static var conn: SQLite.Database = {
        NSLog("[DB] Opening: \(DB.path)")
        return SQLite.Database(DB.path)
    }()

    static func open() -> SQLite.Database {
        NSLog("[DB] Version: \(conn.userVersion)")
        return conn
    }

    static func migrate() {
        for table in tables {
            NSLog("[DB] Creating Table: \(table.tableName)")
            table.create()
        }

        //DBTable.createAll()
    }
    
}

/*
private static var tables = [DBTable]()

static func createAll() {
for table in tables { table.create() }
}

var tableName: String {
assert(false, "Tables must implement tableName getter")
}

var query: SQLite.Query {
return DB.conn[_name]
}

init(name: String) {
_name = name
//DBTable.tables.append(self)
}

func create() {
NSLog("[DB] Creating Table: \(_name)")
DB.conn.create(table: query, ifNotExists: true) { create($0) }
}

func create(table: SQLite.SchemaBuilder) {
assert(false, "DBTable subclass must define a create() method")
}
*/