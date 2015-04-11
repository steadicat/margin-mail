//
//  MainWindowController.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/5/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController, NSWindowDelegate {

    let rootComponent: RootComponent

    convenience init() {
        let window = KeyWindow(
            contentRect: NSMakeRect(0, 0, 1200, 800),
            styleMask: NSBorderlessWindowMask | NSResizableWindowMask | NSClosableWindowMask | NSMiniaturizableWindowMask,
            backing: .Buffered,
            defer: true
        )
        window.backgroundColor = NSColor.whiteColor()
        self.init(window: window)
        self.window!.delegate = self
    }
    
    override init(window: NSWindow?) {
        self.rootComponent = RootComponent(
            frame: window!.frame,
            sidebarColor: NSColor(white: 0.9, alpha: 1)
        )

        super.init(window: window)

        self.window!.contentView = self.rootComponent.renderSelf()
        self.showWindow(self)
        self.window!.center()
        
        var time = dispatch_time(DISPATCH_TIME_NOW, Int64(5 * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            self.rootComponent.sidebarColor = NSColor.whiteColor()
        }
    }
    
    required convenience init?(coder: NSCoder) {
        // XXX: Add support for archiving?
        self.init()
    }
    
    func windowDidResize(notification: NSNotification) {
        let size = self.window!.frame.size
        self.rootComponent.frame = CGRectMake(0, 0, size.width, size.height)
    }
    
}
