//
//  MailStore.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 5/4/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

class MailStore: Store {

    private var clients: [Account: MailClient] = [:]

    override func handleAction(action: Action) {
        switch (action) {
        case let action as MainActions.ActivateAccount:
            subscribe(action.account)
        default:
            break
        }
    }

    private func subscribe(account: Account) {
        if clients[account] == nil {
            clients[account] = createClient(account)
        }
        if let client = clients[account] {
            client.sync()
        }
    }

    private func createClient(account: Account) -> MailClient {
        let client = MailClient(account: account)
        client.onUpdate = { [weak self] in
            self?.notify()
        }
        return client
    }

}

extension MailStore {

    func getFolderByName(account: Account, name: String) -> MailFolder? {
        for folder in clients[account]?.folders ?? [] {
            if folder.name == name {
                return folder
            }
        }
        return nil
    }

    func getFolders(account: Account) -> [MailFolder] {
        return clients[account]?.folders ?? []
    }

    func getMessages(account: Account, folder: MailFolder) -> [MailMessage] {
        return clients[account]?.messages[folder] ?? []
    }

}