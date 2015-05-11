//
//  MailMessage.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/27/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

struct MailMessageID {
    let int: UInt32
    let string: String
    init(_ id: UInt32) {
        int = id
        string = "\(int)"
    }
}

struct MailMessageBody {
    let text: String
    let html: String
}

struct MailMessageFlags {
    let seen: Bool
}

struct MailMessage {

    let folder: MailFolder
    let flags: MailMessageFlags

    let id: MailMessageID
    let sender: MailAddress
    let recipients: [MailAddress]
    let subject: String
    let date: NSDate

    var body: MailMessageBody?

    init(folder: MailFolder, flags: MailMessageFlags, id: MailMessageID, sender: MailAddress, recipients: [MailAddress], date: NSDate, subject: String, body: MailMessageBody?) {
        self.folder = folder
        self.flags = flags
        self.id = id
        self.sender = sender
        self.recipients = recipients
        self.subject = subject
        self.date = date
        self.body = body
    }

    init(message: MCOIMAPMessage, folder: MailFolder) {
        let header = message.header as MCOMessageHeader
        let flags = MailMessageFlags(
            seen: message.flags & .Seen != nil
        )
        self.init(
            folder: folder,
            flags: flags,
            id: MailMessageID(message.uid),
            sender: MailAddress(mco: header.from),
            recipients: header.to.map { MailAddress(mco: $0 as! MCOAddress) },
            date: header.date,
            subject: header.subject,
            body: nil
        )
    }

    mutating func updateWith(data: NSData) {
        let parser = MCOMessageParser(data: data)
        body = MailMessageBody(
            text: parser.plainTextBodyRendering()!,
            html: parser.htmlBodyRendering()!
        )
    }

}