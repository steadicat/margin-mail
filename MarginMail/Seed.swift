//
//  Seed.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/20/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

class Seed {

    static func database() {

        var accounts = AccountStore.getAll()
        if accounts.count == 0 {
            let account = Account(id: nil, name: "Alan", email: "alan@artnez.com")
            Dispatcher.dispatch(Actions.AccountCreate(account: account))
            accounts = AccountStore.getAll()
        }

    }

}