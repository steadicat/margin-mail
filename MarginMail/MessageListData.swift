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
    private var hasLoaded = false

    init(children: [Component] = [], view: NSView? = nil, layer: CALayer? = nil) {
        super.init(
            stores: [Stores().account, Stores().message],
            children: [messageList]
        )
    }

    override func onStoreUpdate() {
        let account: Account! = Stores().account.getActive()
        if account == nil {
            return
        }

        if !hasLoaded {
            hasLoaded = true
            Registry().actions.loadMessages(account)
            return
        }

        messageList.isLoading = Stores().message.isLoading()
        messageList.messages = Stores().message.getMessages(account)
    }

    override func render() {
        messageList.frame = frame
    }

}
