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
    var stores: [Store] = []

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        DB.open()

        stores.extend([
            AccountStore(),
        ])

        mainWindow = MainWindow()
        mainWindow!.show(self)

        Async.delay(3) {
            let account = Account(name: "Artem", email: "artem@artnez.com")
            Dispatcher.dispatch(Action.AccountCreate(account: account))
        }
    }

    func applicationWillTerminate(aNotification: NSNotification) {
    }
    
}
