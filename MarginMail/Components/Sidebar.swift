//
//  Sidebar.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/6/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

let labels = [(0, "Inbox"), (1, "Archive"), (2, "Drafts"), (3, "Sent"), (4, "Starred"), (5, "Spam"), (6, "Trash")]

class Sidebar: View {

    var compose: SidebarItemView
    var items: [SidebarItemView]
    var settings: SidebarItemView

    private var selectedLabel = 0 {
        didSet {
            self.needsDisplay = true
        }
    }

    override init(frame frameRect: CGRect) {
        compose = SidebarItemView(frame: CGRectZero)
        compose.text = "Compose"
        compose.image = NSImage(named: "Compose")
        compose.accentColor = Color.accent()

        items = labels.map { (index, text) in
            var item = SidebarItemView(frame: CGRectZero)
            item.text = text
            item.image = NSImage(named: item.text)
            item.accentColor = Color.accent()
            return item
        }

        settings = SidebarItemView(frame: CGRectZero)
        settings.text = "Settings"
        settings.image = NSImage(named: "Settings")
        settings.accentColor = Color.accent()

        super.init(frame: frameRect)

        compose.onMouseDown = { self.selectedLabel = -1 }
        addSubview(compose)
        for (index, item) in enumerate(self.items) {
            item.onMouseDown = { self.selectedLabel = index }
            addSubview(item)
        }
        settings.onMouseDown = { self.selectedLabel = -2 }
        addSubview(settings)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillDraw() {
        let rowHeight = 36 as CGFloat
        let topMargin = 36 as CGFloat

        // Add a 16px overflow to the right for shrink animation
        var column = bounds.rectByInsetting(dx: 0, dy: 36).extend(right: 16)
        var rows = column.rows()

        compose.frame = rows.next(36)
        compose.isSelected = selectedLabel == -1

        rows.next(18)

        for (index, item) in enumerate(self.items) {
            item.frame = rows.next(36)
            item.isSelected = selectedLabel == index
        }

        settings.frame = CGRectMake(0, bounds.height, bounds.width, 36).offset(dy: -36 - 18)
        settings.isSelected = selectedLabel == -2

        super.viewWillDraw()
    }
    
}
