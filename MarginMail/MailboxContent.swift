//
//  MailboxContent.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 5/10/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class MailboxContent: Component {

    private let list = MessageListData()
    private let pane = MessagePane()
    private let split: Split

    init() {
        split = Split(id: "contentSplitView", children: [list, pane])
        super.init(children: [split])
    }

    override func render() {
        println("render MailboxContent with \(bounds)")

        // TODO: less hacky way to layout the inner views
        split.split.frame = bounds
        let columns = bounds.columns()
        list.messageList.view!.frame = columns.nextFraction(0.5)
        columns.next(split.dividerThickness)
        pane.view!.frame = columns.nextFraction(1)
    }
}
