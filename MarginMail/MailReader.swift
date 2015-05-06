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

protocol MailReader {
    func getAllFolders(callback: [MailFolder] -> Void)
    func getMessagesInFolder(folder: MailFolder, callback: [MailMessage] -> Void)
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

    func getAllFolders(callback: [MailFolder] -> Void) {
        let operation = session.fetchAllFoldersOperation()
        operation.start() { (error, folders) in
            let imapFolders = folders as! [MCOIMAPFolder]
            let mailFolders = imapFolders.map() { MailFolder(folder: $0) }
            let flagFolders = mailFolders.filter() { $0.type != .FOLDER }
            callback(flagFolders)
        }
    }

    func getMessagesInFolder(folder: MailFolder, callback: [MailMessage] -> Void) {
        let requestKind: MCOIMAPMessagesRequestKind = .Headers
        let uids = MCOIndexSet(range: MCORangeMake(1, 5))
        let operation = session.fetchMessagesOperationWithFolder(
            folder.path,
            requestKind: requestKind,
            uids: uids
        )
        operation.start() { (error, receivedMessages, vanishedMessages) in
            let headers: [MailMessageHeader] = receivedMessages.map() { message in
                return MailMessageHeader(message: message as! MCOIMAPMessage, folder: folder)
            }
            self.getMessagesFromHeaders(headers) { messages in
                var messages = messages
                messages.sort({ $0.date.timeIntervalSinceDate($1.date) > 0 })
                callback(messages)
            }
        }
    }

    private func getMessagesFromHeaders(headers: [MailMessageHeader], callback: [MailMessage] -> Void) {
        if headers.count == 0 {
            callback([])
            return
        }
        var messages: [MailMessageID: MailMessage] = [:]
        for header in headers {
            getMessageFromHeader(header) { message in
                messages[message.id] = message
                if messages.count == headers.count {
                    callback(messages.values.array)
                }
            }
        }
    }

    private func getMessageFromHeader(header: MailMessageHeader, callback: MailMessage -> Void) {
        let operation = session.fetchMessageOperationWithFolder(header.folder.path, uid: header.id)
        operation.start() { (error, data) in
            callback(MailMessage(header: header, data: data))
        }
    }
    
}