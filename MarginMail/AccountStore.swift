//
//  AccountStore.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/20/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import SQLite

class AccountStore: Store {

    static func getAll() -> [Account] {
        var accounts: [Account] = []
        for row in AccountTable.all() {
            let account = Account(
                id: row[AccountTable.id],
                name: row[AccountTable.name],
                email: row[AccountTable.email]
            )
            accounts.append(account)
        }
        return accounts
    }

    override func action(action: Any) {
        switch (action) {
        case let action as Actions.AccountCreate:
            createAccount(action.account)
        default:
            return
        }
    }

    private func createAccount(account: Account) {
        let stmt: SQLite.Statement = AccountTable.query().insert(
            AccountTable.name <- account.name,
            AccountTable.email <- account.email
        )
    }

}
