//
//  Table.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/18/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import SQLite

protocol Table {
    static func query() -> SQLite.Query
    static func all() -> SQLite.Query
    static func create()
}