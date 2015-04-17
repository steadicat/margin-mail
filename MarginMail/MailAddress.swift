//
//  MailAddress.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/17/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

class MailAddress {

    let addr: String
    let name: String?

    private let mco: MCOAddress

    init(mco: MCOAddress) {
        self.mco = mco
        self.addr = mco.mailbox
        self.name = mco.displayName
    }

    convenience init(addr: String, name: String) {
        self.init(mco: MCOAddress(displayName: name, mailbox: addr))
    }

    convenience init(addr: String) {
        self.init(mco: MCOAddress(mailbox: addr))
    }
    
}
