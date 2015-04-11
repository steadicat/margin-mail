//
//  SidebarComponent.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/6/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
//

import Cocoa

class SidebarComponent: Component {

    let labels = [(0, "Inbox"), (1, "Archive"), (2, "Drafts"), (3, "Sent"), (4, "Starred"), (5, "Spam"), (6, "Trash")]
    private var selectedLabel = 0 {
        didSet {
            self.needsRender()
        }
    }
    private var highlightedLabel = -1 {
        didSet {
            self.needsRender()
        }
    }
    
    let frame: CGRect
    let color: NSColor
    
    init(frame: CGRect, color: NSColor, children: [Component?] = []) {
        self.frame = frame
        self.color = color
        super.init(children: children)
    }
    
    override func render() -> Component {
        let rowHeight = 36 as CGFloat
        let sideMargin = 36 as CGFloat
        let topMargin = 36 as CGFloat
        
        let inboxColor = self.selectedLabel == 0 ? NSColor(hue: 0.56, saturation: 1, brightness: 1, alpha: 1) : NSColor(white: 0.3, alpha: 1)
        let inboxIcon = NSImage(named: "Inbox")?.tintedImageWithColor(inboxColor)
        
        return View(
            frame: self.frame,
            backgroundColor: self.color,
            children: self.labels.map { (index, text) in
                Button(
                    frame: CGRectMake(0, self.frame.height - topMargin - rowHeight * CGFloat(index + 1), self.frame.width, rowHeight),
                    text: text,
                    textColor: index == self.selectedLabel ? NSColor(hue: 0.56, saturation: 1.0, brightness: 1.0, alpha: 1.0) : NSColor(white: 0.3, alpha: 1),
                    backgroundColor: index == self.highlightedLabel ? NSColor(hue: 0.56, saturation: 0.05, brightness: 1.0, alpha: 1.0) : nil,
                    bordered: false,
                    font: NSFont(name: (index == self.selectedLabel ? "OpenSans-Semibold" : "OpenSans"), size: 14),
                    image: index == 0 ? inboxIcon : nil,
                    leftMargin: sideMargin,
                    onMouseDown: { self.selectedLabel = index },
                    onMouseEnter: { self.highlightedLabel = index },
                    onMouseExit: { self.highlightedLabel = -1 }
                )
            }
        )
    }
    
}
