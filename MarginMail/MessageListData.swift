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
            stores: [Stores().account, Stores().mail],
            children: [messageList]
        )
    }

    override func render() {}

}
