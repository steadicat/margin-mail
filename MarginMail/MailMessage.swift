//
//  MailMessage.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/27/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

struct MailMessage {

    let recipients: [MailAddress]
    let sender: MailAddress
    let subject: String
    let body: String // XXX: Changing

}