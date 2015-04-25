//
//  Sidebar.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/6/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class Sidebar: Component {

    static let minimumWidth: CGFloat = 66
    static let maximumWidth: CGFloat = 216

    private let topMargin: CGFloat = 36
    private let spaceHeight: CGFloat = 18
    private let rowHeight: CGFloat = 36

    private var inboxCount = 0 {
        didSet {
            self.needsUpdate = true
        }
    }

    private var selectedItem = "" {
        didSet {
            self.needsUpdate = true
        }
    }

    private var items: [(String, SidebarItemView)] = []

    init() {
        let view = View(frame: CGRectZero)
        super.init(children: [], view: view)

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
            item.onMouseDown = {
                self.selectedItem = id
            }
            view.addSubview(item)
        }

        view.backgroundColor = Color.white()
    }

    func createItem(id: String, text: String) -> (String, SidebarItemView) {
        var item = SidebarItemView(frame: CGRectZero)
        item.text = text
        item.image = NSImage(named: item.text)
        item.accentColor = Color.accent()
        return (id, item)
    }

    override func render() {
        // Add a 16px overflow to the right for shrink animation
        var column = bounds.rectByInsetting(dx: 0, dy: topMargin).extend(right: 16)
        var rows = column.rows()

        for (id, item) in self.items {
            item.isSelected = selectedItem == id

            if id == "inbox" && inboxCount > 0 {
                item.badge = String(inboxCount)
            }

            if id == "settings" {
                item.frame = CGRectMake(0, bounds.height, bounds.width + 16, rowHeight).offset(dy: -rowHeight - spaceHeight)
            } else {
                item.frame = rows.next(rowHeight)
            }

            if id == "compose" {
                rows.next(spaceHeight)
            }
        }
    }
    
}
