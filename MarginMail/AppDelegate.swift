//
//  AppDelegate.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/5/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var mainWindow: MainWindow?

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        Registry().stores.account.addListener(self) {
            println("Account changed!")
        }
        Registry().actions.account.createTestAccount()
        Registry().stores.account.removeListener(self)

        let activeAccount = Registry().stores.account.getActiveAccount()
        println("Active: \(activeAccount)")

        mainWindow = MainWindow()
        mainWindow!.show(self)
    }

    func applicationWillTerminate(aNotification: NSNotification) {
    }
    
}