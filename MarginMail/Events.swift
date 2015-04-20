//
//  Events.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/20/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

class Listener<T> {

    typealias Handler = T -> Void
    typealias Disposer = (Listener<T>) -> Void

    var handler: Handler
    var disposer: Disposer

    init(handler: Handler, disposer: Disposer) {
        self.handler = handler
        self.disposer = disposer
    }

    func invoke(data: T) {
        self.handler(data)
    }

    func dispose() {
        self.disposer(self)
    }

}

class Event<T> {

    typealias Handler = T -> Void

    var listeners: [Listener<T>] = []

    func listen(handler: Handler) -> Listener<T> {
        let listener = Listener<T>(handler: handler) { self.dispose($0) }
        Lock.mutex(self) {
            listeners.append(listener)
        }
        return listener
    }

    func dispose(listener: Listener<T>) {
        Lock.mutex(self) {
            listeners = listeners.filter({ $0 !== listener })
        }
    }

    func emit(data: T) {
        for listener in listeners {
            listener.invoke(data)
        }
    }

}
