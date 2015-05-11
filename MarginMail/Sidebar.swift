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

    var updateItem: ((SidebarItem, Int) -> Void)?
    var onItemClick: ((SidebarItem) -> Void)?

    var itemCount = 0

    var items: [SidebarItem] = [] {
        didSet {
            needsUpdate = true
        }
    }

    var selectedItem: String = "" {
        didSet {
            needsUpdate = true
        }
    }

    private let compose: SidebarItem
    private let settings: SidebarItem

    private let topMargin: CGFloat = 36
    private let spaceHeight: CGFloat = 18
    private let rowHeight: CGFloat = 36

    init() {
        let view = View(frame: CGRectZero)
        view.backgroundColor = Color.white()

        compose = SidebarItem()
        compose.key = "compose"
        compose.text = "Compose"
        compose.image = NSImage(named: "Compose")

        settings = SidebarItem()
        settings.key = "settings"
        settings.text = "Settings"
        settings.image = NSImage(named: "Settings")

        super.init(children: [], view: view)
    }

    func reloadItems() {
        for i in 0..<itemCount {
            if i >= items.count {
                items.append(createItem())
                children.append(items[i])
            }
        }
        for i in itemCount..<items.count {
            items.removeAtIndex(i)
            children[i].view?.removeFromSuperview()
        }
    }

    override func render() {
        let column = view!.bounds.rectByInsetting(dx: 0, dy: topMargin).extend(right: SidebarItem.rightBleed)
        let rows = column.rows()
        for (i, item) in enumerate(items) {
            renderItem(item, row: i, rows: rows)
        }
    }

    private func createItem() -> SidebarItem {
        let item = SidebarItem()
        item.onMouseDown = { [weak self] in
            self?.onItemClick?(item)
        }
        return item
    }

    private func renderItem(var item: SidebarItem!, row: Int, rows: RowGenerator) {
        updateItem?(item, row)

        item.isSelected = item.key == selectedItem

        if item.key == "settings" {
            rows.nextFraction(1)
        }

        item.frame = rows.next(rowHeight)

        if item.key == "compose" {
            rows.next(spaceHeight)
        }
    }

}
