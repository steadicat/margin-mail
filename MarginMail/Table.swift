//
//  Table.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/18/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import SQLite

protocol Table {
    var tableName: String { get }
    var query: SQLite.Query { get }

    func create()
    func create(table: SQLite.SchemaBuilder)
}
