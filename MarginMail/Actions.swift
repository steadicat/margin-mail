//
//  Actions.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/27/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

class MainActions: ActionCreator {

    struct ActivateAccount: Action {
        let account: Account
    }

    struct CreateAccount: Action {
        let account: Account
        let activate: Bool
    }

    struct LoadMessages: Action {
        let account: Account
    }

    struct LoadMessagesSuccess: Action {
        let account: Account
        let messages: [MailMessage]
    }

}