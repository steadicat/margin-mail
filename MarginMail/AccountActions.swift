//
//  AccountActions.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/25/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

extension MainActions {

    func activateAccount(account: Account) {
        dispatch(ActivateAccount(account: account))
    }

    func createAccount(account: Account, activate: Bool = false) {
        dispatch(CreateAccount(account: account, activate: activate))
    }

    func createTestAccount() {
        let account = Account(
            name: "Alan",
            email: "alan@artnez.com"
        )
        account.incoming = IMAPTransport(
            hostname: "imap.gmail.com",
            port: 993,
            username: "alan@artnez.com",
            password: "entscheidungsproblem"
        )
        createAccount(account, activate: true)
    }

}