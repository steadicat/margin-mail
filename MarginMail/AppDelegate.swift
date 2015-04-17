//
//  AppDelegate.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/16/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var mainWindow: MainWindow?

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        DB.connect()
        DB.migrate()

        mainWindow = MainWindow()
        mainWindow!.show(self)
    }

    func applicationWillTerminate(aNotification: NSNotification) {
    }
    
}
