//
//  MainWindowController.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/5/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
//

import Cocoa

class MainWindowController: NSObject, NSWindowDelegate {

    let window: Window
    let rootView: RootView

    override init() {
        window = Window(
            contentRect: NSMakeRect(0, 0, 1200, 800),
            styleMask: NSBorderlessWindowMask | NSResizableWindowMask | NSClosableWindowMask | NSMiniaturizableWindowMask,
            backing: .Buffered,
            defer: true
        )
        
        rootView = RootView(frame: self.window.frame)
        rootView.sidebarColor = NSColor(white: 0.9, alpha: 1)

        super.init()
        
        window.backgroundColor = NSColor.whiteColor()
        window.delegate = self
        window.contentView = rootView
        window.makeKeyAndOrderFront(self)
        window.center()
        
        weak var weakSelf = self
        var time = dispatch_time(DISPATCH_TIME_NOW, Int64(5 * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            weakSelf?.rootView.sidebarColor = NSColor.whiteColor()
        }
    }
    
    func windowDidResize(notification: NSNotification) {
        let size = window.frame.size
        rootView.frame = CGRectMake(0, 0, size.width, size.height)
    }
    
}
