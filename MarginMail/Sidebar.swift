//
//  Sidebar.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/6/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class Sidebar: View {

    var items: [(String, SidebarItemView)] = []

    private var selectedItem = "" {
        didSet {
            self.needsDisplay = true
        }
    }

    private var inboxCount = 0

    override init(frame frameRect: CGRect) {
        super.init(frame: frameRect)

        self.items = [
            createItem("compose", text: "Compose"),
            createItem("inbox", text: "Inbox"),
            createItem("archive", text: "Archive"),
            createItem("drafts", text: "Drafts"),
            createItem("sent", text: "Sent"),
            createItem("starred", text: "Starred"),
            createItem("spam", text: "Spam"),
            createItem("trash", text: "Trash"),
            createItem("settings", text: "Settings"),
        ]

        for (id, item) in self.items {
            item.onMouseDown = { self.selectedItem = id }
            addSubview(item)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createItem(id: String, text: String) -> (String, SidebarItemView) {
        var item = SidebarItemView(frame: CGRectZero)
        item.text = text
        item.image = NSImage(named: item.text)
        item.accentColor = Color.accent()
        return (id, item)
    }

    override func viewWillDraw() {
        // Add a 16px overflow to the right for shrink animation
        var column = bounds.rectByInsetting(dx: 0, dy: 36).extend(right: 16)
        var rows = column.rows()

        for (id, item) in self.items {
            item.isSelected = selectedItem == id

            if id == "inbox" {
                item.badge = String(inboxCount)
            }

            if id == "settings" {
                item.frame = CGRectMake(0, bounds.height, bounds.width, 36).offset(dy: -36 - 18)
            } else {
                item.frame = rows.next(36)
            }

            if id == "compose" {
                rows.next(18)
            }
        }

        super.viewWillDraw()
    }
    
}
