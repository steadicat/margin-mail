//
//  Account.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/25/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

struct Account: Hashable {

    let id: NSUUID
    let name: String
    let email: String
    let photo: NSImage?

    let incoming: Transport?
    let outgoing: Transport?

    let address: MailAddress

    init(name: String, email: String, photo: NSImage?, incoming: Transport?, outgoing: Transport?) {
        self.id = NSUUID()
        self.name = name
        self.email = email
        self.photo = photo
        self.incoming = incoming
        self.outgoing = outgoing
        self.address = MailAddress(addr: email, name: name)
    }

    var hashValue: Int {
        return id.hashValue
    }

}

func ==(lhs: Account, rhs: Account) -> Bool {
    return lhs.id == rhs.id
}