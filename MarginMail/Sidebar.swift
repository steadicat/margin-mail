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

    var items: [Navigation.Item] = [] {
        didSet {
            needsUpdate = true
        }
    }

    var selectedItem: String = "" {
        didSet {
            needsUpdate = true
        }
    }

    private var sidebarItems: [SidebarItem] = []

    var onItemClick: ((SidebarItem) -> Void)?

    init() {
        let view = View(frame: CGRectZero)
        super.init(children: [], view: view)
        view.backgroundColor = Color.white()
    }

    override func render() {
        var column = view!.bounds.rectByInsetting(dx: 0, dy: topMargin).extend(right: SidebarItem.rightBleed)
        var rows = column.rows()

        for i in 0..<items.count {
            self.renderChild(i < sidebarItems.count ? sidebarItems[i] : nil, item: items[i], rows: rows)
        }
        for i in items.count..<sidebarItems.count {
            sidebarItems.removeLast()
            children.removeLast()
        }
    }

    func renderChild(var child: SidebarItem!, item: Navigation.Item, rows: RowGenerator) -> SidebarItem {
        if child == nil {
            child = SidebarItem()
            sidebarItems.append(child)
            children.append(child)
        }

        child.onMouseDown = { [weak self] in
            self?.onItemClick?(child)
        }

        child.isSelected = item.key == selectedItem

        child.key = item.key
        child.text = item.label
        child.image = NSImage(named: item.label)

        let inboxCount = 0
        if item.key == "inbox" && inboxCount > 0 {
            child.badge = String(inboxCount)
        } else {
            child.badge = ""
        }


        if item.key == "settings" {
            child.frame = CGRectMake(0, bounds.height, bounds.width + 16, rowHeight).offset(dy: -rowHeight - spaceHeight)
        } else {
            child.frame = rows.next(self.rowHeight)
        }

        if item.key == "compose" {
            rows.next(self.spaceHeight)
        }
        
        return child
    }

}
