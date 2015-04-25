//
//  AccountStore.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/26/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

class AccountStore: Store {

    let db: Database

    private var accounts: [Account] = []
    private var activeAccount: Account?

    init(_ dispatcher: Dispatcher, db: Database) {
        self.db = db
        super.init(dispatcher)
    }

    override func handleAction(action: Action) {
        switch action {
        case let action as AccountActions.CreateAccount:
            self.accounts.append(action.account)
            emitChange()
            break
        case let action as AccountActions.ActivateAccount:
            self.activeAccount = action.account
            emitChange()
        default:
            break
        }
    }

    func getAll() -> [Account] {
        return self.accounts
    }

    func getActiveAccount() -> Account? {
        return activeAccount
    }

}
