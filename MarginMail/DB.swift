//
//  DB.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/17/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import SQLite

class DB {

    static var conn: SQLite.Database = {
        let path = Config.dataURL.URLByAppendingPathComponent("db.sqlite3").path!
        NSLog("[DB] Opening: \(path)")
        return SQLite.Database(path)
    }()

    static func version() -> Int {
        return DB.conn.userVersion
    }

    static func open() -> SQLite.Database {
        NSLog("[DB] Version: \(DB.version())")
        return conn
    }

    static func migrate() {
        for (i, migration) in enumerate(migrations) {
            if version() <= i {
                NSLog("[DB] Migrating: \(i) -> \(i+1)")
                migration()
                conn.userVersion++
            }
        }
    }

    static var migrations: [() -> Void] = [
        {
            MailboxTable.create()
            TransportTable.create()
        }
    ]
    
}