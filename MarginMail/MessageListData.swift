//
//  MessageListData.swift
//  
//
//  Created by Stefano J. Attardi on 4/27/15.
//
//

import Cocoa

class MessageListData: DataComponent {

    let messageList = MessageList()

    init(children: [Component] = [], view: NSView? = nil, layer: CALayer? = nil) {
        super.init(
            stores: [Stores().navigation],
            children: [messageList]
        )
        messageList.onMessageSelect = { message in
            Actions().navigate(.MESSAGE, key: message.id.string)
        }
    }

    override func onStoreUpdate() {
        messageList.selectedMessageID = Stores().navigation.getSelected(.MESSAGE)
    }

    override func render() {
        println("render MessageListData with \(bounds)")
    }

}