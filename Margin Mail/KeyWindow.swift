//
//  Window.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/5/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
//

import Cocoa

class Window: NSWindow {
    
    override var canBecomeKeyWindow:Bool {
        get {
            return true;
        }
    }

}
