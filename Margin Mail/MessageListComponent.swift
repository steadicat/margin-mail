//
//  MessageListComponent.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/6/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
//

import Cocoa

class MessageListComponent: Component {
    
    override func render() -> Component {
        return View(props: [
            "frame": self.props["frame"]!,
            "backgroundColor": NSValue(nonretainedObject: NSColor.orangeColor()),
        ])
    }
    
}
