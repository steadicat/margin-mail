//
//  MailReader.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/17/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

enum MailReaderType: String {
    case IMAP = "imap"
}

protocol MailReader {}

class IMAPReader: MailReader {

    private var hostname: String
    private var port: Int
    private var username: String?
    private var password: String?

    private let connectionType: MCOConnectionType = .TLS

    lazy private var session: MCOIMAPSession = {
        let session = MCOIMAPSession()
        session.hostname = self.hostname
        session.port = UInt32(truncatingBitPattern: self.port)
        if let username = self.username {
            session.username = username
        }
        if let password = self.password {
            session.password = password
        }
        return session
        }()

    init(hostname: String, port: Int = 993, username: String? = nil, password: String? = nil) {
        self.hostname = hostname
        self.port = port
        self.username = username
        self.password = password
    }
    
}
