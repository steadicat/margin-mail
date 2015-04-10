//
//  SidebarComponent.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/6/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
//

import Cocoa

class SidebarComponent: Component {

    var frame: CGRect
    var color: NSColor
    
    init(frame: CGRect, color: NSColor, children: [Component?] = []) {
        self.frame = frame
        self.color = color
        super.init(children: children)
    }
    
    override func render() -> Component {
        return View(
            frame: self.frame,
            backgroundColor: self.color,
            children: [
                TextField(frame: CGRectMake(20, self.frame.height - 40, self.frame.width - 40, 20))
            ]
        )
    }
    
}
