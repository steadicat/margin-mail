//
//  Sidebar.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/6/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
//

import Cocoa

class Sidebar: View {

    let labels = [(0, "Inbox"), (1, "Archive"), (2, "Drafts"), (3, "Sent"), (4, "Starred"), (5, "Spam"), (6, "Trash")]
    
    var color: NSColor?
    var items: [SidebarItemView]

    private var selectedLabel = 0 {
        didSet {
            self.needsDisplay = true
        }
    }
    
    override init(frame frameRect: NSRect) {
        self.items = labels.map { (index, text) in
            var button = SidebarItemView(frame: CGRectZero)
            button.text = text
            return button
        }

        super.init(frame: frameRect)
    
        for (index, item) in enumerate(self.items) {
            item.onMouseDown = { self.selectedLabel = index }
            self.addSubview(item)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillDraw() {
        let rowHeight = 36 as CGFloat
        let topMargin = 36 as CGFloat
        
        let inboxColor = self.selectedLabel == 0 ? Color.accent() : Color.mediumGray()
        let inboxIcon = NSImage(named: "Inbox")?.tintedImageWithColor(inboxColor)
        
        backgroundColor = self.color

        for (index, item) in enumerate(self.items) {
            item.frame = CGRectMake(0, frame.height - topMargin - rowHeight * CGFloat(index + 1), frame.width, rowHeight)
            item.isSelected = index == selectedLabel
            item.image = index == 0 ? inboxIcon : nil
            item.sideMargin = (item.image == nil ? 32 : 0)
        }
        
        super.viewWillDraw()
    }
    
}
