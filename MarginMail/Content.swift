//
//  Content.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/19/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class Content: Component {

    private let split: Split
    private let messageList = MessageList()
    private let messagePane = MessagePane()

    init() {
        split = Split(id: "contentSplitView", children: [messageList, messagePane])

        super.init(children: [split], view: nil)
    }

    override func render() {
        //split.frame = bounds

        if CGRectIsEmpty(messageList.view!.frame) || CGRectIsEmpty(messagePane.frame) {
            let columns = bounds.columns()
            messageList.frame = columns.nextFraction(0.5)
            columns.next(split.dividerThickness)
            messagePane.frame = columns.nextFraction(1)
        }
    }

}
