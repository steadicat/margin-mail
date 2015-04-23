//
//  Content.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/19/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class Content: Component {

    private let split: SplitView
    private let messageList: MessageList
    private let messagePane: View

    override init() {
        split = SplitView(frame: CGRectZero)
        messageList = MessageList()
        messagePane = View(frame: CGRectZero)

        super.init()

        if let subview = messageList.view {
            split.addSubview(subview)
        }
        split.addSubview(messagePane)

        messagePane.backgroundColor = Color.white()

        split.identifier = "contentSplitView"
        split.autosaveName = "contentSplitView"

        if CGRectIsEmpty(messageList.frame) {
            let columns = bounds.columns()
            messageList.frame = columns.next(0.5)
            columns.next(split.dividerThickness)
            messagePane.frame = columns.nextFraction(1)
        }
    }

    func render() {
        split.frame = bounds

    }

    var view: NSView? {
        get {
            return split
        }
    }
}
