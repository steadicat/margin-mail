//
//  DB.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/17/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import SQLite


class DB {

    static let name = "db.sqlite3"

    static var url: NSURL = {
        return Config.dataURL.URLByAppendingPathComponent(DB.name)
    }()

    static var path: String = {
        return DB.url.path!
    }()

    static var conn: Database = {
        NSLog("Opening DB: \(DB.path)")
        return Database(DB.path)
    }()

    static func connect() -> Database {
        return self.conn
    }

    static func migrate() {}

}
