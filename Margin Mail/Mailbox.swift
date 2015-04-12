//
//  Mailbox.swift
//  Margin Mail
//
//  Created by Artem Nezvigin on 4/12/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
//

class Mailbox {

    var accounts: [MailAccount] = []

    func addAccount(account: MailAccount) {
        self.accounts.append(account)
    }

}