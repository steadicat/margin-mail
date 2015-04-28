//
//  MailReader.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/17/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

enum MailReaderType: String {
    case IMAP = "imap"
}

protocol MailReader {
    func getMessages(callback: [MailMessage] -> Void)
}

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
        session.connectionType = self.connectionType
        return session
    }()

    init(hostname: String, port: Int = 993, username: String? = nil, password: String? = nil) {
        self.hostname = hostname
        self.port = port
        self.username = username
        self.password = password
    }

    // XXX: This method is temporary. Just for testing.
    func getMessages(callback: [MailMessage] -> Void) {
        let requestKind: MCOIMAPMessagesRequestKind = .Headers
        let folder = "INBOX"
        let uids = MCOIndexSet(range: MCORangeMake(1, 5))
        let operation = session.fetchMessagesOperationWithFolder(
            folder,
            requestKind: requestKind,
            uids: uids
        )
        operation.start() { (error, receivedMessages, vanishedMessages) in
            var messages: [MailMessage] = []
            for message in receivedMessages as! [MCOIMAPMessage] {
                messages.append(self.createMessage(message))
            }
            callback(messages)
        }
    }

    private func createMessage(source: MCOIMAPMessage) -> MailMessage {
        let header: MCOMessageHeader = source.header as MCOMessageHeader
        return MailMessage(
            recipients: header.to.map { MailAddress(mco: $0 as! MCOAddress) },
            sender: MailAddress(mco: header.from),
            subject: header.subject,
            body: "..."
        )
    }
    
}