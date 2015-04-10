//
//  MainWindowController.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/5/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

    let rootComponent: RootComponent

    convenience init() {
        let window = KeyWindow(
            contentRect: NSMakeRect(0, 0, 700, 700),
            styleMask: NSBorderlessWindowMask | NSResizableWindowMask | NSClosableWindowMask | NSMiniaturizableWindowMask,
            backing: .Buffered,
            defer: true
        )
        window.backgroundColor = NSColor.whiteColor()
        self.init(window: window)
    }
    
    override init(window: NSWindow?) {
        rootComponent = RootComponent(
            frame: window!.frame,
            sidebarColor: NSColor.blueColor()
        )

        super.init(window: window)

        self.window!.contentView = rootComponent.renderSelf()
        self.showWindow(self)
        self.window!.center()
        
        var time = dispatch_time(DISPATCH_TIME_NOW, Int64(5 * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            self.rootComponent.sidebarColor = NSColor.purpleColor()
        }
    }
    
    required convenience init?(coder: NSCoder) {
        // XXX: Add support for archiving?
        self.init()
    }
    
}
