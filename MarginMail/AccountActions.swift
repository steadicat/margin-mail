//
//  AccountActions.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/25/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

class AccountActions: ActionCreator {

    struct ActivateAccount: Action {
        let account: Account
    }

    struct CreateAccount: Action {
        let account: Account
    }

    func createAccount(account: Account) {
        dispatch(CreateAccount(account: account))
    }

    func createTestAccount() {
        let account = Account(name: "Alan", email: "alan@artnez.com")
        createAccount(account)
        activateAccount(account)
    }

    func activateAccount(account: Account) {
        dispatch(ActivateAccount(account: account))
    }

}