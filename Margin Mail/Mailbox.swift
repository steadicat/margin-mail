//
//  Mailbox.swift
//  Margin Mail
//
//  Created by Artem Nezvigin on 4/12/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//


protocol MailboxMessageDelegate {
    func mailboxMessagesDidArrive(account: MailAccount, messages: [MailMessage])
}

class Mailbox {

    var messageDelegate: MailboxMessageDelegate?

    private var accounts: [MailAccount] = []

    func addAccounts(accounts: MailAccount...) {
        self.accounts.extend(accounts)
    }

    func listenForMessages() {
        self.accounts.each(self.fetchMessagesForAccount)
    }

    private func fetchMessagesForAccount(account: MailAccount) {
        account.fetch() { (messages: [MailMessage]) in
            self.messageDelegate?.mailboxMessagesDidArrive(account, messages: messages)
        }
    }

}