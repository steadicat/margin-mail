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

    var updateItem: ((SidebarItem, Int, Int) -> Void)?
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

    private let topMargin: CGFloat = 36
    private let spaceHeight: CGFloat = 18
    private let rowHeight: CGFloat = 36

    init() {
        let view = View(frame: CGRectZero)
        view.backgroundColor = Color.white()

        super.init(children: items, view: view)
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
        let column = view!.bounds.extend(right: SidebarItem.rightBleed)
        let rows = column.rows()
        rows.next(topMargin)
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
        updateItem?(item, row, items.count)

        item.isSelected = item.key == selectedItem

        if item.key == "settings" {
            rows.nextFraction(1)
            item.frame = rows.next(rowHeight).offset(dy: -rowHeight - spaceHeight)
        } else {
            item.frame = rows.next(rowHeight)
        }

        if item.key == "compose" {
            rows.next(spaceHeight)
        }
    }

}
