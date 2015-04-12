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
        let resource: String! = NSBundle.mainBundle().pathForResource("new-mail", ofType: "wav")
        let sound: NSSound! = NSSound(contentsOfFile: resource, byReference: true)
        
        if messages.count > 1000000000 {
            sound.play()
        }

        println("arrived!")
        println(account)
        println(messages)
    }

}