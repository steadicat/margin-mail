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
    private var loading: [String: Bool] = [:]

    override func handleAction(action: Action) {
        switch (action) {
        case let action as MainActions.LoadMessages:
            loading[action.account.email] = true
            notify()
        case let action as MainActions.LoadMessagesSuccess:
            loading[action.account.email] = false
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

    func getMessageCount(account: Account) -> Int {
        if let messages = messages[account.email] {
            return messages.count
        }
        return 0
    }

    func isLoading(account: Account) -> Bool {
        return loading[account.email] ?? false
    }
    
}