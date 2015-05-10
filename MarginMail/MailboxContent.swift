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
        split.frame = bounds

        let columns = bounds.columns()
        split.children[0].frame = columns.nextFraction(0.5)
        columns.next(split.dividerThickness)
        split.children[1].frame = columns.nextFraction(1)
    }
}
