//
//  MailMessage.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/27/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

typealias MailMessageID = UInt32

struct MailMessageHeader {

    let folder: MailFolder

    let id: MailMessageID
    let sender: MailAddress
    let recipients: [MailAddress]
    let subject: String
    let date: NSDate

    init(message: MCOIMAPMessage, folder: MailFolder) {
        self.folder = folder

        let headers = message.header as MCOMessageHeader
        id = message.uid
        sender = MailAddress(mco: headers.from)
        recipients = headers.to.map { MailAddress(mco: $0 as! MCOAddress) }
        subject = headers.subject
        date = headers.date
    }
}

struct MailMessage {

    let folder: MailFolder

    let id: MailMessageID
    let sender: MailAddress
    let recipients: [MailAddress]
    let subject: String
    let date: NSDate

    let body: String

    init(header: MailMessageHeader, data: NSData) {
        self.folder = header.folder

        id = header.id
        sender = header.sender
        recipients = header.recipients
        subject = header.subject
        date = header.date

        body = MCOMessageParser(data: data).plainTextBodyRendering()!
    }

}