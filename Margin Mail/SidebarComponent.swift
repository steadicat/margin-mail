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
        let bold = NSFontManager.sharedFontManager().convertFont(NSFont.systemFontOfSize(NSFont.systemFontSize()), toHaveTrait: .BoldFontMask)
        return View(
            frame: self.frame,
            backgroundColor: self.color,
            children: [
                LabelComponent(
                    frame: CGRectMake(20, self.frame.height - 40, self.frame.width - 40, 20),
                    text: "Inbox",
                    textColor: NSColor(hue: 0.6, saturation: 0.8, brightness: 1, alpha: 1),
                    font: bold
                ),
                LabelComponent(
                    frame: CGRectMake(20, self.frame.height - 72, self.frame.width - 40, 20),
                    text: "Archive",
                    textColor: NSColor(white: 0.3, alpha: 1)
                ),
                LabelComponent(
                    frame: CGRectMake(20, self.frame.height - 104, self.frame.width - 40, 20),
                    text: "Drafts",
                    textColor: NSColor(white: 0.3, alpha: 1)
                )
            ]
        )
    }
    
}
