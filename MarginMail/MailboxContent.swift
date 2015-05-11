//
//  MailboxContent.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 5/10/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class MailboxContent: DataComponent {

    private var messages: [MailMessage] = []

    private let list = MessageListData()
    private let pane = MessagePane()
    private let split: Split

    init() {
        split = Split(id: "contentSplitView", children: [list, pane])
        super.init(
            stores: [Stores().navigation, Stores().mail],
            children: [split]
        )
    }

    override func onStoreUpdate() {
        let selected = Stores().navigation.getSelected(.MAIN)
        if let account = Stores().account.getActive() {
            if let folder = Stores().mail.getFolder(account, name: selected) {
                messages = Stores().mail.getMessages(account, folder: folder)
            }
        }
    }

    override func render() {
        println("render MailboxContent with \(bounds)")

        // TODO: less hacky way to layout the inner views
        split.split.frame = bounds

        let columns = bounds.columns()

        list.messageList.messages = messages
        list.messageList.view!.frame = columns.nextFraction(0.5)

        columns.next(split.dividerThickness)
        pane.view!.frame = columns.nextFraction(1)
    }
}
