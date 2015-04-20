//
//  Lock.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/19/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class Lock {

    static func with(lock: AnyObject, @noescape block: () -> Void) {
        objc_sync_enter(lock)
        block()
        objc_sync_exit(lock)
    }

}
