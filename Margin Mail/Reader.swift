//
//  Reader.swift
//  Margin Mail
//
//  Created by Artem Nezvigin on 4/12/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

protocol MailReader {
    func fetch(callback: [MailMessage] -> Void)
}

class IMAPReader: MailReader {

    private var hostname: String
    private var port: UInt32
    private var username: String
    private var password: String

    private var connectionType: MCOConnectionType = .TLS

    private var _session: MCOIMAPSession?
    private var session: MCOIMAPSession {
        get {
            if _session == nil {
                _session = self.createSession()
            }
            return _session!
        }
    }

    init(hostname: String, port: UInt32, username: String, password: String) {
        self.hostname = hostname
        self.port = port
        self.username = username
        self.password = password
    }

    func fetch(callback: [MailMessage] -> Void) {
        let requestKind: MCOIMAPMessagesRequestKind = .Headers;
        let folder = "INBOX"
        let uids = MCOIndexSet(range: MCORangeMake(1, 5))

        let operation = self.session.fetchMessagesOperationWithFolder(
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
        let to: MailAddress = header.to[0] as! MailAddress
        let from: MailAddress = header.from as MailAddress
        return MailMessage(to: to, from: from, subject: header.subject)
    }

    private func createSession() -> MCOIMAPSession {
        let session = MCOIMAPSession()
        session.hostname = self.hostname
        session.port = self.port
        session.username = self.username
        session.password = self.password
        session.connectionType = self.connectionType
        return session
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