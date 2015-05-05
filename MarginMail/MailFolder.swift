//
//  MailFolder.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 5/4/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

enum MailFolderType {
    case INBOX
    case ARCHIVE
    case SENT
    case SPAM
    case TRASH
    case DRAFTS
}

class MailFolder {

    var name: String
    var type: MailFolderType

    var messageCount = 0

    init(folder: MCOIMAPFolder) {
        name = "foo"
        type = .INBOX
    }

}