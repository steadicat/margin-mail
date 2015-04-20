//
//  Account.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/17/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class Account {

    var name: String
    var email: String
    var photo: NSImage?

    var incoming: Transport?
    var outgoing: Transport?

    init(name: String, email: String) {
        self.name = name
        self.email = email
    }

    lazy var address: MailAddress = {
        return MailAddress(addr: self.email, name: self.name)
    }()

    lazy var client: MailClient = {
        return MailClient(
            address: self.address,
            reader: self.incoming?.createReader(),
            writer: self.outgoing?.createWriter()
        )
    }()
    
}
