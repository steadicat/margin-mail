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
        Actions().createTestAccount()

        Dispatch.after(2) {
            Actions().hideMainMenuItem("archive")
        }
        Dispatch.after(3) {
            Actions().showMainMenuItem("archive")
            Actions().hideMainMenuItem("compose")
        }
        Dispatch.after(4) {
            Actions().showMainMenuItem("compose")
        }

        mainWindow = MainWindow()
        mainWindow!.show(self)
    }

    func applicationWillTerminate(aNotification: NSNotification) {
    }
    
}