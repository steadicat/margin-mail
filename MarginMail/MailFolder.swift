//
//  MailFolder.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 5/4/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

enum MailFolderType: String {

    case INBOX = "Inbox"
    case ARCHIVE = "Archive"
    case SENT = "Sent"
    case SPAM = "Spam"
    case TRASH = "Trash"
    case DRAFTS = "Drafts"
    case FOLDER = "Folder"

    init(folder: MCOIMAPFolder) {
        if folder.path == "INBOX" {
            self = .INBOX
        } else if folder.flags & .Drafts != nil {
            self = .DRAFTS
        } else if folder.flags & .SentMail != nil {
            self = .SENT
        } else if folder.flags & .Archive != nil {
            self = .ARCHIVE
        } else if folder.flags & .Spam != nil {
            self = .SPAM
        } else if folder.flags & .Trash != nil {
            self = .TRASH
        } else {
            self = .FOLDER
        }
    }

}

struct MailFolder: Hashable {

    let name: String
    let path: String
    let type: MailFolderType

    var numTotalMessages = 0
    var numUnreadMessages = 0

    private let lock = NSObject()
    private var syncing = false

    init(path: String, name: String, type: MailFolderType) {
        self.path = path
        self.type = type
        self.name = name
    }

    init(path: String, type: MailFolderType = .FOLDER) {
        self.init(path: path, name: path.lastPathComponent, type: type)
    }

    init(folder: MCOIMAPFolder) {
        // XXX: Use `folder.delimeter` for extracing name. Using the last path
        // component does not conform to the IMAP spec.
        let path = folder.path
        let type = MailFolderType(folder: folder)
        let name = (type == .FOLDER) ? path.lastPathComponent : type.rawValue
        self.init(path: path, name: name, type: type)
    }

    mutating func updateWith(status: MCOIMAPFolderStatus) {
        numTotalMessages = Int(status.messageCount)
        numUnreadMessages = Int(status.unseenCount)
    }

    var hashValue: Int {
        return path.hashValue
    }

}

func ==(lhs: MailFolder, rhs: MailFolder) -> Bool {
    return lhs.path == rhs.path
}