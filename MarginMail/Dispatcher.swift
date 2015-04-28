//
//  Dispatcher.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/25/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

class Dispatcher {

    typealias Handler = Action -> ()

    var handlers: [Handler] = []
    private let mutex = NSObject()

    func register(handler: Handler) {
        Lock.with(mutex) {
            handlers.append(handler)
        }
    }

    func dispatch(action: Action) {
        Dispatch.queue() {
            NSLog("Dispatching: \(action)")
            for handler in self.handlers {
                handler(action)
            }
        }
    }

}