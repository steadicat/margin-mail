//
//  SidebarView.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/6/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
//

import Cocoa

class SidebarView: View {

    let labels = [(0, "Inbox"), (1, "Archive"), (2, "Drafts"), (3, "Sent"), (4, "Starred"), (5, "Spam"), (6, "Trash")]
    
    var color: NSColor?
    var buttons: [Button]

    private var selectedLabel = 0 {
        didSet {
            self.needsDisplay = true
        }
    }
    private var highlightedLabel = -1 {
        didSet {
            self.needsDisplay = true
        }
    }
    
    override init(frame frameRect: NSRect) {
        self.buttons = self.labels.map { (index, text) in
            var button = Button(frame: CGRectZero)
            button.text = text
            return button
        }

        super.init(frame: frameRect)
        
        weak var weakSelf = self
    
        for (index, button) in enumerate(self.buttons) {
            button.onMouseDown = { weakSelf?.selectedLabel = index }
            button.onMouseEnter = { weakSelf?.highlightedLabel = index }
            button.onMouseExit = { weakSelf?.highlightedLabel = -1 }
            self.addSubview(button)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillDraw() {
        let rowHeight = 36 as CGFloat
        let sideMargin = 36 as CGFloat
        let topMargin = 36 as CGFloat
        
        let inboxColor = self.selectedLabel == 0 ? NSColor(hue: 0.56, saturation: 1, brightness: 1, alpha: 1) : NSColor(white: 0.3, alpha: 1)
        let inboxIcon = NSImage(named: "Inbox")?.tintedImageWithColor(inboxColor)
        
        self.backgroundColor = self.color

        for (index, button) in enumerate(self.buttons) {
            button.frame = CGRectMake(0, self.frame.height - topMargin - rowHeight * CGFloat(index + 1), self.frame.width, rowHeight)
            button.textColor = index == self.selectedLabel ? NSColor(hue: 0.56, saturation: 1.0, brightness: 1.0, alpha: 1.0) : NSColor(white: 0.3, alpha: 1)
            button.backgroundColor = index == self.highlightedLabel ? NSColor(hue: 0.56, saturation: 0.05, brightness: 1.0, alpha: 1.0) : nil
            button.bordered = false
            button.font = NSFont(name: (index == self.selectedLabel ? "OpenSans-Semibold" : "OpenSans"), size: 14)
            button.image = index == 0 ? inboxIcon : nil
            button.leftMargin = sideMargin
        }
        
        super.viewWillDraw()
    }
    
}
