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

        // Hide and show several navigation items. States should transition
        // smoothly and the end state should be deterministic.
        Dispatch.after(2) {
            Actions().hideMainMenuItem("archive")
        }
        Dispatch.after(3) {
            Actions().showMainMenuItem("archive")
            Actions().hideMainMenuItem("compose")
            Actions().hideMainMenuItem("settings")
        }
        Dispatch.after(4) {
            Actions().showMainMenuItem("compose")
            Actions().showMainMenuItem("settings")
        }

        // Randomly select a navigation item in quick succession. Helps expose
        // race conditions caused by thread unsafe mutations.
        Dispatch.after(2) {
            let pages = Stores().navigation.getMainMenuKeys()
            for n in 0...200 {
                Dispatch.after(Double(n) / 50) {
                    let page = pages[Int.random(pages.count - 1)]
                    Actions().navigateMainMenu(page)
                }
            }
        }

        mainWindow = MainWindow()
        mainWindow!.show(self)
    }

    func applicationWillTerminate(aNotification: NSNotification) {
    }
    
}