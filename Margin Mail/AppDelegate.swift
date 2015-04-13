//
//  AppDelegate.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/5/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, MailboxMessageDelegate {
    
    var mainWindow: MainWindow!
    var mailbox: Mailbox!
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let alan = GmailAccount(username: "alan@artnez.com", password: "entscheidungsproblem")

        mailbox = Mailbox()
        mailbox.addAccounts(alan)
        mailbox.messageDelegate = self

        mainWindow = MainWindow()
        mainWindow.show(self)

        mailbox.listenForMessages()
    }
    
    func applicationWillTerminate(aNotification: NSNotification) {
    }

    func mailboxMessagesDidArrive(account: MailAccount, messages: [MailMessage]) {
        println("arrived!")
        println(account)
        println(messages)
    }

}