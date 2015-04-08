//
//  MessageListComponent.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/6/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
//

import Cocoa

struct MessageListProps {
    var frame: NSRect
    var backgroundColor: NSColor?
}

class MessageListComponent: Component {

    var props: MessageListProps

    init(props: MessageListProps) {
        self.props = props
        super.init(children: [])
    }
    
    override func render() -> Component {
        return View(props: ViewProps(
            frame: self.props.frame,
            backgroundColor: NSColor.orangeColor()
        ))
    }
    
}
