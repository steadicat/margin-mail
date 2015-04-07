//
//  AppDelegate.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/5/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var windowController: NSWindowController?
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        self.windowController = MainWindowController()
    }
    
    func applicationWillTerminate(aNotification: NSNotification) {
    }


}

