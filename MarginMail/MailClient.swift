//
//  MailClient.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/17/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

class MailClient {

    var address: MailAddress

    private var reader: MailReader?
    private var writer: MailWriter?

    init(address: MailAddress, reader: MailReader?, writer: MailWriter?) {
        self.address = address
        self.reader = reader
        self.writer = writer
    }

    // XXX: This method is temporary. Just for testing.
    func getMessages(callback: [MailMessage] -> Void) {
        self.reader!.getMessages(callback)
    }
    
}
