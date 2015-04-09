//
//  MessageListComponent.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/6/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
//

import Cocoa

class MessageListComponent: Component {
    
    var frame: CGRect
    var color: NSColor
    var showLoading: Bool
    
    init(frame: CGRect, color: NSColor, showLoading: Bool, children: [Component] = []) {
        self.frame = frame
        self.color = color
        self.showLoading = showLoading
        super.init(children: children)
    }
    
    override func render() -> Component {
        return View(
            frame: self.frame,
            backgroundColor: self.color,
            children: self.showLoading ? [
                TextField(frame: CGRectMake(self.frame.width / 2 - 40, self.frame.height / 2 - 10, 80, 20), text: "Loading...")
            ] : []
        )
    }
    
}
