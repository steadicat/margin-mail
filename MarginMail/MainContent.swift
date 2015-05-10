//
//  MainContent.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/19/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class MainContent: DataComponent {

    private var content: Component?
    private var selected: String = ""

    private lazy var mailboxContent = MailboxContent()
    private lazy var emptyContent = EmptyContent()

    init() {
        let view = View()
        view.backgroundColor = NSColor.orangeColor()

        super.init(stores: [Stores().navigation], children: [], view: view)
    }

    override func onStoreUpdate() {
        selected = Stores().navigation.selectedMainMenuItem?.key ?? ""
        needsUpdate = true
    }

    override func render() {
        switch (selected) {
        case "inbox":
            children = [mailboxContent]
            mailboxContent.frame = bounds

        default:
            children = [emptyContent]
            emptyContent.frame = bounds
        }
    }


}
