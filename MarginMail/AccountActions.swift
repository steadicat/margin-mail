//
//  AccountActions.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/25/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

class AccountActions: ActionCreator {

    struct Activate: Action {
        let account: Account
    }

    struct Create: Action {
        let account: Account
        let activate: Bool
    }

    func activate(account: Account) {
        dispatch(Activate(account: account))
    }

    func create(account: Account, activate: Bool = false) {
        dispatch(Create(account: account, activate: activate))
    }

    func createTest() {
        let account = Account(name: "Alan", email: "alan@artnez.com")
        create(account, activate: true)
    }

}