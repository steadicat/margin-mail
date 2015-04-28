//
//  AccountStore.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/26/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

class AccountStore: Store {

    private let db: Database

    private var accounts: [Account] = []
    private var active: Account?

    init(_ dispatcher: Dispatcher, db: Database) {
        self.db = db
        super.init(dispatcher)
    }

    override func handleAction(action: Action) {
        switch (action) {
        case let action as MainActions.CreateAccount:
            create(action.account)
            activate(action.account)
            notify()
        case let action as MainActions.ActivateAccount:
            activate(action.account)
            notify()
        default:
            break
        }
    }

    private func create(account: Account) {
        accounts.append(account)
    }

    private func activate(account: Account) {
        active = account
    }

}

extension AccountStore {

    func getAll() -> [Account] {
        return accounts
    }

    func getActive() -> Account? {
        return active
    }

}