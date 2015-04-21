//
//  DB.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/17/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import SQLite

class DB {

    static var name = "db2.sqlite3"

    static var path: String = {
        return Config.dataURL.URLByAppendingPathComponent(name).path!
    }()

    static var conn: SQLite.Database = {
        NSLog("[DB] Opening: \(DB.path)")
        return SQLite.Database(DB.path)
    }()

    static func version() -> Int {
        return conn.userVersion
    }

    static func open() -> SQLite.Database {
        NSLog("[DB] Version: \(version())")
        createFunctions()
        runMigrations()
        return conn
    }

    static func createFunctions() {
        let _ = [Func.uuid]
    }

    struct Func {
        static let uuid = conn.create(function: "uuid") {
            return NSUUID()
        }()
    }

    static func runMigrations() {
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
            AccountTable.create()
            TransportTable.create()
        }
    ]
    
}