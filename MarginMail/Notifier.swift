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

    struct Listener {
        // FIXME: There *seems* to be a bug in Swift when handling an optional
        // AnyObject value. Simply assigning raises an EXC_BAD_ACCESS with code
        // EXC_I386_GPFLT. When this is fixed (or we find the real cause), set
        // context to weak which will ensure that contexts are not held as a
        // strong reference, removing the need to manually unregister the
        // listener just to handle deallocation.
        let context: Context
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
        let listener = Listener(context: context, callback: callback)
        Lock.with(mutex) {
            listeners.append(listener)
        }
    }

    func removeListener(context: Context) {
        listeners = listeners.filter() { listener in
            return listener.context != nil && listener.context !== context
        }
    }

}