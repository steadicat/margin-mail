//
//  Account.swift
//  Margin Mail
//
//  Created by Artem Nezvigin on 4/12/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

class MailAccount {
    var reader: MailReader
    var writer: MailWriter

    init(reader: MailReader, writer: MailWriter) {
        self.reader = reader
        self.writer = writer
    }

    func fetch(callback: [MailMessage] -> Void) {
        self.reader.fetch(callback)
    }

}

class GmailAccount: MailAccount {

    init(username: String, password: String) {
        let reader = GmailReader(username: username, password: password)
        let writer = GmailWriter(username: username, password: password)
        super.init(reader: reader, writer: writer)
    }

}