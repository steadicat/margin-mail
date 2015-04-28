//
//  Actions.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/25/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

protocol Action {
    // Used as a marker interface for now.
}

class Actions {

    let dispatcher: Dispatcher

    init(_ dispatcher: Dispatcher) {
        self.dispatcher = dispatcher
    }

    func dispatch(action: Action) {
        dispatcher.dispatch(action)
    }

}