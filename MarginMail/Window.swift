//
//  Window.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/17/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class Window: NSWindow {

    override var canBecomeKeyWindow: Bool {
        get {
            return true
        }
    }

    override var canBecomeMainWindow: Bool {
        get {
            return true
        }
    }

}
