//
//  AppDelegate.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/5/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var mainWindow: MainWindow!
    var mailbox: Mailbox!
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        mailbox = Mailbox()
        mailbox.addAccount(GmailAccount(
            username: "alan@artnez.com",
            password: "entscheidungsproblem"
        ))

        mainWindow = MainWindow()
        mainWindow.show(self)
    }
    
    func applicationWillTerminate(aNotification: NSNotification) {
    }


}