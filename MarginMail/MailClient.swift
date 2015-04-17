//
//  MailClient.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/17/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

class MailClient {

    var address: MailAddress
    var reader: MailReader?
    var writer: MailWriter?

    init(address: MailAddress, reader: MailReader?, writer: MailWriter?) {
        self.address = address
        self.reader = reader
        self.writer = writer
    }
    
}
