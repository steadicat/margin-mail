//
//  MessageListData.swift
//  
//
//  Created by Stefano J. Attardi on 4/27/15.
//
//

import Cocoa

class MessageListData: DataComponent {

    private let messageList = MessageList()

    init(children: [Component] = [], view: NSView? = nil, layer: CALayer? = nil) {
        super.init(
            stores: [Stores().account, Stores().mail],
            children: [messageList]
        )
    }

    override func onStoreUpdate() {
        if let account = Stores().account.getActive() {
//            messageList.isLoading = Stores().message.isLoading(account)
//            messageList.messages = Stores().message.getMessages(account)
        }
    }

    override func render() {
        println("render MessageListData with \(bounds)")
        messageList.frame = bounds
    }

}
