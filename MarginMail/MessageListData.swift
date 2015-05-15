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

    init() {
        super.init(
            stores: [Stores().navigation, Stores().mail],
            children: [messageList]
        )
        messageList.onMessageSelect = { message in
            Actions().navigate(.MESSAGE, key: message.id.string)
        }
    }

    override func onStoreUpdate() {
        let selected = Stores().navigation.getSelected(.MAIN)
        if let account = Stores().account.getActive() {
            if let folder = Stores().mail.getFolder(account, name: selected) {
                messageList.messages = Stores().mail.getMessages(account, folder: folder)
            }
        }

        messageList.selectedMessageID = Stores().navigation.getSelected(.MESSAGE)
    }

    override func render() {
    }

}