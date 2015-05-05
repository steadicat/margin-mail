//
//  MailStore.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 5/4/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

class MailStore: Store, MailDelegate {

    private var clients: [Account: MailClient] = [:]

    override func handleAction(action: Action) {
        switch (action) {
        case let action as MainActions.ActivateAccount:
            activate(action.account)
        default:
            break
        }
    }

    private func activate(account: Account) {
        deactivate()
        if clients[account] == nil {
            clients[account] = MailClient(account: account)
        }
        if let client = clients[account] {
            client.delegate = self
            client.mode = .ACTIVE
            client.sync()
        }
    }

    private func deactivate() {
        for client in clients.values {
            client.mode = .PASSIVE
        }
    }

}

extension MailStore {

//    func getAll() -> [Account] {
//        return accounts
//    }
//
//    func getActive() -> Account? {
//        return active
//    }

}