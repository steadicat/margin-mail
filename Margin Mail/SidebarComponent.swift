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
    
    let frame: CGRect
    let color: NSColor
    
    init(frame: CGRect, color: NSColor, children: [Component?] = []) {
        self.frame = frame
        self.color = color
        super.init(children: children)
    }
    
    override func render() -> Component {
        let rowHeight = 32 as CGFloat
        let sideMargin = 32 as CGFloat
        let topMargin = 32 as CGFloat
        
        return View(
            frame: self.frame,
            backgroundColor: self.color,
            children: self.labels.map { (index, text) in
                Button(
                    frame: CGRectMake(sideMargin, self.frame.height - topMargin - rowHeight * CGFloat(index + 1), self.frame.width - sideMargin, rowHeight),
                    text: text,
                    textColor: index == self.selectedLabel ? NSColor(hue: 0.56, saturation: 1.0, brightness: 1.0, alpha: 1.0) : NSColor(white: 0.3, alpha: 1),
                    bordered: false,
                    font: NSFont(name: (index == self.selectedLabel ? "OpenSans-Semibold" : "OpenSans"), size: 14),
                    onClick: { self.selectedLabel = index }
                )
            }
        )
    }
    
}
