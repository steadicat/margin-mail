//
//  Sidebar.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/6/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class Sidebar: DataComponent {

    static let minimumWidth: CGFloat = 66
    static let maximumWidth: CGFloat = 216

    private let topMargin: CGFloat = 36
    private let spaceHeight: CGFloat = 18
    private let rowHeight: CGFloat = 36

    private static let items = [
        ("compose", text: "Compose"),
        ("inbox", text: "Inbox"),
        ("archive", text: "Archive"),
        ("drafts", text: "Drafts"),
        ("sent", text: "Sent"),
        ("starred", text: "Starred"),
        ("spam", text: "Spam"),
        ("trash", text: "Trash"),
        ("settings", text: "Settings")
    ]

    private let items: [SidebarItem]

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

    private var account: Account? = nil {
        didSet {
            self.needsUpdate = true
        }
    }

    init() {
        let view = View(frame: CGRectZero)
        items = Sidebar.items.map { Sidebar.createItem($0.0, text: $0.text) }

        super.init(
            stores: [Stores().account, Stores().message],
            children: items,
            view: view
        )

        for item in items {
            item.onMouseDown = { [weak self] in
                self?.selectedItem = item.key
            }
        }

        view.backgroundColor = Color.white()
    }

    static func createItem(key: String, text: String) -> SidebarItem {
        var item = SidebarItem()
        item.key = key
        item.text = text
        item.image = NSImage(named: item.text)
        return item
    }

    override func onStoreUpdate() {
        account = Stores().account.getActive()
        inboxCount = account == nil ? 0 : Stores().message.getMessages(account!).count
    }

    override func render() {
        var column = bounds.rectByInsetting(dx: 0, dy: topMargin).extend(right: SidebarItem.rightBleed)
        var rows = column.rows()

        for item in items {
            item.isSelected = selectedItem == item.key

            if item.key == "inbox" && inboxCount > 0 {
                item.badge = String(inboxCount)
            }

            if item.key == "settings" {
                item.frame = CGRectMake(0, bounds.height, bounds.width + 16, rowHeight).offset(dy: -rowHeight - spaceHeight)
                item.text = account?.name ?? "No account"
            } else {
                item.frame = rows.next(rowHeight)
            }

            if item.key == "compose" {
                rows.next(spaceHeight)
            }
        }
    }
    
}
