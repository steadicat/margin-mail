//
//  Dispatcher.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/20/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

class Dispatcher {

    typealias Context = AnyObject
    typealias Callback = Any -> Void
    typealias Delegate = (context: WeakContext, callback: Callback)

    class WeakContext {
        weak var object: Context?
        init(_ object: Context) {
            self.object = object
        }
    }

    static let globalContext = NSObject()
    static let mutex = NSObject()

    static var delegates: [Delegate] = []

    static func register(context: Context, _ callback: Callback) {
        Lock.with(mutex) {
            self.delegates.append((WeakContext(context), callback))
        }
    }

    static func register(callback: Callback) {
        register(globalContext, callback)
    }

    static func dispatch(action: Any) {
        for delegate in delegates {
            delegate.callback(action)
        }
    }

    static func dispose(context: AnyObject) {
        delegates = delegates.filter { delegate in
            return delegate.context.object != nil && delegate.context.object !== context
        }
    }

}