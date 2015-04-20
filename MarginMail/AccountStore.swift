//
//  AccountStore.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/20/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

class AccountStore: Store {

    override func action(action: Any) {
        switch (action) {
        case let action as Action.AccountCreate:
            createAccount(action.account)
        default:
            return
        }
    }

    private func createAccount(account: Account) {
        println("Create account: \(account.name)")
    }

}