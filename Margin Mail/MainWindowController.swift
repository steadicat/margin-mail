//
//  MainWindowController.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/5/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController, ComponentDelegate {

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
        rootComponent = RootComponent(props: RootProps(
            frame: window!.frame,
            sidebarColor: NSColor.blueColor()
        ))

        super.init(window: window)

        rootComponent.delegate = self
        rootComponent.needsRender()
        
        var time = dispatch_time(DISPATCH_TIME_NOW, Int64(5 * Double(NSEC_PER_SEC)))

        /*
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            self.rootComponent.props = [
                "frame": NSValue(rect: window!.frame),
                "sidebarColor": NSValue(nonretainedObject: NSColor.purpleColor()),
            ]
        }
        */
    }
    
    required convenience init?(coder: NSCoder) {
        // XXX: Add support for archiving?
        self.init()
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    func componentRendered(view: NSView) {
        self.window!.contentView = view
        self.showWindow(self)
        self.window!.center()
    }

}
