//
//  Notifier.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/26/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

class Notifier {

    typealias Context = AnyObject
    typealias Callback = Void -> Void

    struct WeakContext {
        // FIXME: Should be weak. Didn't do it yet because it was being
        // deallocated in `addListener`.
        var object: Context?
    }

    struct Listener {
        let context: WeakContext
        let callback: Callback
    }

    var listeners: [Listener] = []

    private let mutex = NSObject()

    func notifyListeners() {
        for listener in listeners {
            listener.callback()
        }
    }

    func addListener(context: Context, callback: Callback) {
        let listener = Listener(
            context: WeakContext(object: context),
            callback: callback
        )
        Lock.with(mutex) {
            listeners.append(listener)
        }
    }

    func removeListener(context: Context) {
        listeners = listeners.filter() { listener in
            return listener.context.object != nil
                && listener.context.object !== context
        }
    }

}