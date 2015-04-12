//
//  Sidebar.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/6/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

let labels = [(0, "Inbox"), (1, "Archive"), (2, "Drafts"), (3, "Sent"), (4, "Starred"), (5, "Spam"), (6, "Trash")]

class Sidebar: View {

    var items: [SidebarItemView]

    private var selectedLabel = 0 {
        didSet {
            self.needsDisplay = true
        }
    }
    
    override init(frame frameRect: CGRect) {
        self.items = labels.map { (index, text) in
            var item = SidebarItemView(frame: CGRectZero)
            item.text = text
            return item
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
        
        var column = bounds.rectByInsetting(dx: 0, dy: 36)
        var rows = column.rows()
        
        for (index, item) in enumerate(self.items) {
            item.frame = rows.next(36)
            item.isSelected = index == selectedLabel
            item.image = NSImage(named: "Inbox")
        }
        
        super.viewWillDraw()
    }
    
}
