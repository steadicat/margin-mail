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
        
        opaque = false
        backgroundColor = NSColor.clearColor()
        
        contentView = main
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show(sender: AnyObject?) {
        self.makeKeyAndOrderFront(sender)
        self.center()
    }
    
}
