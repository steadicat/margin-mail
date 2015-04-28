//
//  Transport.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/27/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

protocol Transport {
    func createReader() -> MailReader?
    func createWriter() -> MailWriter?
}

class IMAPTransport: Transport {

    let hostname: String
    let port: Int
    let username: String
    let password: String

    init(hostname: String, port: Int, username: String, password: String) {
        self.hostname = hostname
        self.port = port
        self.username = username
        self.password = password
    }

    func createReader() -> MailReader? {
        return IMAPReader(
            hostname: hostname,
            port: port,
            username: username,
            password: password
        )
    }

    func createWriter() -> MailWriter? {
        return nil
    }

}