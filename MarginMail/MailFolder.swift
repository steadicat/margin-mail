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

    static func from(folder: MCOIMAPFolder) -> MailFolderType {
        if folder.path == "INBOX" {
            return .INBOX
        } else if folder.flags & .Drafts != nil {
            return .DRAFTS
        } else if folder.flags & .SentMail != nil {
            return .SENT
        } else if folder.flags & .Archive != nil {
            return .ARCHIVE
        } else if folder.flags & .Spam != nil {
            return .SPAM
        } else if folder.flags & .Trash != nil {
            return .TRASH
        } else {
            return .FOLDER
        }
    }
}

class MailFolder {

    var name: String
    var type: MailFolderType

    var messageCount = 0

    init(folder: MCOIMAPFolder) {
        name = folder.path.lastPathComponent  // XXX: Use `folder.delimiter`
        type = MailFolderType.from(folder)
    }

}