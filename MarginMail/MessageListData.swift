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

    override init(children: [Component] = [], view: NSView? = nil, layer: CALayer? = nil) {
        super.init(children: [messageList])
    }

    override func getStoresToWatch(stores: Stores) -> [Store] {
        return [stores.account, stores.message]
    }

    override func getDataFromStores(stores: Stores) {
        let account: Account! = stores.account.getActive()
        if account == nil {
            return
        }

        if !hasLoaded {
            hasLoaded = true
            Registry().actions.loadMessages(account)
            return
        }

        messageList.isLoading = stores.message.isLoading()
        messageList.messages = stores.message.getMessages(account)
    }

    override func render() {
        messageList.frame = frame
    }

}
