//
//  Account.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/25/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class Account {

    let name: String
    let email: String
    let photo: NSImage?

    var incoming: IncomingTransport?

    lazy var address: MailAddress = {
        return MailAddress(addr: self.email, name: self.name)
    }()

    init(name: String, email: String, photo: NSImage? = nil) {
        self.name = name
        self.email = email
        self.photo = photo
    }

    lazy var client: MailClient = {
        return MailClient(
            address: self.address,
            reader: self.incoming?.createReader(),
            writer: nil
        )
    }()

}