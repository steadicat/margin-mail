//
//  Writer.swift
//  Margin Mail
//
//  Created by Artem Nezvigin on 4/12/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

class MailWriter {}

class SMTPWriter: MailWriter {

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

class GmailWriter: SMTPWriter {

    init(username: String, password: String) {
        super.init(
            hostname: "smtp.gmail.com",
            port: 465,
            username: username,
            password: password
        )
    }
    
}