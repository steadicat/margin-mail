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

// XXX: This whole thing will be cleaned up later.

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
        findMessages() { messages in
            self.loadMessages(messages) { messages in
                callback(messages)
            }
        }
    }

    // XXX: This method is temporary. Just for testing.
    private func findMessages(callback: [MCOIMAPMessage] -> Void) {
        let requestKind: MCOIMAPMessagesRequestKind = .Headers
        let uids = MCOIndexSet(range: MCORangeMake(1, 5))
        let operation = session.fetchMessagesOperationWithFolder(
            "INBOX",
            requestKind: requestKind,
            uids: uids
        )
        operation.start() { (error, receivedMessages, vanishedMessages) in
            var messages: [MCOIMAPMessage] = []
            for message in receivedMessages as! [MCOIMAPMessage] {
                messages.append(message)
            }
            callback(messages)
        }
    }

    // XXX: This method is temporary. Just for testing.
    private func loadMessages(messagesToLoad: [MCOIMAPMessage], callback: [MailMessage] -> Void) {
        var loadedMessages: [MailMessageID: MailMessage] = [:]
        for message in messagesToLoad {
            let operation = session.fetchMessageOperationWithFolder("INBOX", uid: message.uid)
            operation.start() { (error, data) in
                loadedMessages[message.uid] = self.createMessage(message, data: data)
                if loadedMessages.count == messagesToLoad.count {
                    var messages = loadedMessages.values.array
                    messages.sort({ $0.date.timeIntervalSinceDate($1.date) > 0 })
                    callback(messages)
                }
            }
        }
    }

    private func createMessage(message: MCOIMAPMessage, data: NSData) -> MailMessage {
        let headers = message.header as MCOMessageHeader
        let parser = MCOMessageParser(data: data)

        let recipients = headers.to.map { MailAddress(mco: $0 as! MCOAddress) }
        let sender = MailAddress(mco: headers.from)
        let subject = headers.subject
        let body = parser.plainTextBodyRendering()!
        let date = headers.date

        return MailMessage(
            id: message.uid,
            recipients: recipients,
            sender: sender,
            subject: subject,
            body: body,
            date: date
        )
    }
    
}