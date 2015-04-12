//
//  Reader.swift
//  Margin Mail
//
//  Created by Artem Nezvigin on 4/12/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
//

class MailReader {}

class IMAPReader: MailReader {

    var hostname: String
    var port: Int
    var username: String
    var password: String

    var connectionType: MCOConnectionType = .TLS

    init(hostname: String, port: Int, username: String, password: String) {
        self.hostname = hostname
        self.port = port
        self.username = username
        self.password = password
    }

}

class GmailReader: IMAPReader {

    init(username: String, password: String) {
        super.init(
            hostname: "imap.gmail.com",
            port: 993,
            username: username,
            password: password
        )
    }

}