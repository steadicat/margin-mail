//
//  MessageStore.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/27/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

class MessageStore: Store {

    private var accounts: [Account] = []
    private var active: Account?

    private var messages: [String: [MailMessage]] = [:]
    private var loading = false

    override func handleAction(action: Action) {
        switch (action) {
        case let action as Actions.LoadMessages:
            loading = true
            notify()
        case let action as Actions.LoadMessagesSuccess:
            loading = false
            messages[action.account.email] = action.messages
            notify()
        default:
            break
        }
    }

}

extension MessageStore {

    func getMessages(account: Account) -> [MailMessage] {
        return messages[account.email] ?? []
    }

    func isLoading() -> Bool {
        return loading
    }
    
}