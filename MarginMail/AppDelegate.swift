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
        let store = Registry().stores.account
        let action = Registry().actions.account

        store.addListener(self) { println("Account changed!") }
        action.createTestAccount()
        store.removeListener(self)

        println("Active: \(store.getActiveAccount())")

        mainWindow = MainWindow()
        mainWindow!.show(self)
    }

    func applicationWillTerminate(aNotification: NSNotification) {
    }
    
}