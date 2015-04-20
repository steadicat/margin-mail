//
//  AppDispatcher.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/19/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class AppDispatcher {

    typealias ActionListener = (AnyObject) -> Void

    static private var listeners: [ActionListener] = []

    static func dispatch(action: AnyObject) {
        for listener in listeners {
            listener(action)
        }
    }

    static func register(listener: ActionListener) {
        listeners.append(listener)
    }

}
