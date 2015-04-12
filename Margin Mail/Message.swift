//
//  Message.swift
//  Margin Mail
//
//  Created by Artem Nezvigin on 4/12/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

typealias MailAddress = MCOAddress

class MailMessage {

    var to: MailAddress
    var from: MailAddress
    var subject: String

    init(to: MailAddress, from: MailAddress, subject: String) {
        self.to = to
        self.from = from
        self.subject = subject
    }

}