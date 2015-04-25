//
//  Database.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/26/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

class Database {

    let name: String
    let path: String

    init(name: String, url: NSURL) {
        self.name = name
        self.path = url.URLByAppendingPathComponent(name).path!
    }

}