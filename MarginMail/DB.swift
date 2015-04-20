//
//  DB.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/17/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import SQLite

class DB {

    static var path: String = {
        return Config.dataURL.URLByAppendingPathComponent("db.sqlite3").path!
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
        migrate()
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

    static func seed() {
        let mailboxes = MailboxStore.all()
        if mailboxes.count == 0 {
            println("no mailboxes")
        }


        // let alan = GmailAccount(username: "alan@artnez.com", password: "entscheidungsproblem")
        //let mailbox = MailboxTable.all().first
        //println(mailbox)
        //MailboxStore.seed()
    }
    
}