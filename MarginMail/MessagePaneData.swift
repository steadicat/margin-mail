//
//  MessagePane.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 5/11/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class MessagePaneData: DataComponent {

    let messagePane = MessagePane()

    init(children: [Component] = [], view: NSView? = nil, layer: CALayer? = nil) {
        super.init(
            stores: [Stores().navigation],
            children: [messagePane]
        )
    }

    override func onStoreUpdate() {
        if let account = Stores().account.getActive() {
            let messageID = Stores().navigation.getSelected(.MESSAGE)
            messagePane.message = Stores().mail.getMessage(account, id: messageID)
        } else {
            messagePane.message = nil
        }
    }

    override func render() {
        println("render MessagePaneData with \(bounds)")
    }
    
}