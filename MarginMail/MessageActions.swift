//
//  MessageActions.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/27/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

extension MainActions {

    func loadMessages(account: Account) {
        dispatch(LoadMessages(account: account))
        account.client.getMessages() { messages in
            self.dispatch(LoadMessagesSuccess(account: account, messages: messages))
        }
    }
    
}