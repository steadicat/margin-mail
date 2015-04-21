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

    let stores: [Store] = [
        AccountStore()
    ]

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        DB.open()
        Seed.database()

        mainWindow = MainWindow()
        mainWindow!.show(self)
    }

    func applicationWillTerminate(aNotification: NSNotification) {
    }
    
}
