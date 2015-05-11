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

protocol MailReader: class {
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
        operation.start() { (error, result) in
            var folders = self.convertFolders(result as! [MCOIMAPFolder])
            self.refreshFolders(folders) { folders in
                callback(folders)
            }
        }
    }

    func getMessagesInFolder(folder: MailFolder, callback: [MailMessage] -> Void) {
        let uids = MCOIndexSet(range: MCORangeMake(1, 5))
        let operation = session.fetchMessagesOperationWithFolder(
            folder.path,
            requestKind: .Headers | .Flags,
            uids: MCOIndexSet(range: MCORangeMake(1, 5))
        )
        operation.start() { (error, receivedMessages, vanishedMessages) in
            let messages = self.convertMessages(
                receivedMessages as! [MCOIMAPMessage],
                folder: folder
            )
            self.refreshMessages(messages) { messages in
                callback(messages)
            }
        }

    }

    private func refreshFolders(var folders: [MailFolder], callback: [MailFolder] -> Void) {
        var finished = 0
        for (i, folder) in enumerate(folders) {
            session.folderStatusOperation(folder.path).start() { (error, status) in
                if error == nil {
                    folders[i].updateWith(status)
                }
                if ++finished == folders.count {
                    callback(folders)
                }
            }
        }
    }

    private func convertFolders(folders: [MCOIMAPFolder]) -> [MailFolder] {
        return folders.map() { folder in
            return MailFolder(folder: folder)
        }.filter() { folder in
            return folder.type != .FOLDER
        }
    }

    private func refreshMessages(var messages: [MailMessage], callback: [MailMessage] -> Void) {
        var finished = 0
        for (i, message) in enumerate(messages) {
            let operation = session.fetchMessageOperationWithFolder(message.folder.path, uid: message.id.int)
            operation.start() { (error, data) in
                if error == nil {
                    messages[i].updateWith(data)
                }
                if ++finished == messages.count {
                    callback(messages)
                }
            }
        }
    }

    private func convertMessages(messages: [MCOIMAPMessage], folder: MailFolder) -> [MailMessage] {
        return messages.map() { message in
            return MailMessage(message: message, folder: folder)
        }
    }

}