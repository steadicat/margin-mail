//
//  MainWindow.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/5/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class MainWindow: Window {

    var main: Main

    init() {
        let frame = NSMakeRect(0, 0, 1200, 800)
        main = Main(frame: frame)
        
        super.init(
            contentRect: frame,
            styleMask: NSBorderlessWindowMask | NSResizableWindowMask | NSClosableWindowMask | NSMiniaturizableWindowMask,
            backing: .Buffered,
            defer: true
        )
        
        contentView = main
        backgroundColor = Color.white()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show(sender: AnyObject?) {
        self.makeKeyAndOrderFront(sender)
        self.center()
        
        weak var weakSelf = self
        var time = dispatch_time(DISPATCH_TIME_NOW, Int64(5 * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue()) { weakSelf?.main.sidebarColor = NSColor.whiteColor() }
    }
    
}
