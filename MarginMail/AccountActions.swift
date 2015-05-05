//
//  AccountActions.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/25/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

extension MainActions {

    struct ActivateAccount: Action {
        let account: Account
    }

    struct CreateAccount: Action {
        let account: Account
    }

    func activateAccount(account: Account) {
        dispatch(ActivateAccount(account: account))
    }

    func createAccount(account: Account) {
        dispatch(CreateAccount(account: account))
    }

    func createTestAccount() {
        let incoming = IMAPTransport(
            hostname: "imap.gmail.com",
            port: 993,
            username: "alan@artnez.com",
            password: "entscheidungsproblem"
        )
        let account = Account(
            name: "Alan",
            email: "alan@artnez.com",
            photo: nil,
            incoming: incoming,
            outgoing: nil
        )
        createAccount(account)
        activateAccount(account)
    }

}