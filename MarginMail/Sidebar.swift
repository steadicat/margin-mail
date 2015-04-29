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

    var account: Account? = nil {
        didSet {
            self.needsUpdate = true
        }
    }

    var inboxCount = 0 {
        didSet {
            self.needsUpdate = true
        }
    }

    var menu: NavigationStore.Menu? = nil {
        didSet {
            self.updateMenuItems()
            self.needsUpdate = true
        }
    }

    private let topMargin: CGFloat = 36
    private let spaceHeight: CGFloat = 18
    private let rowHeight: CGFloat = 36

    private let items: [SidebarItem] = []

    init() {
        let view = View(frame: CGRectZero)
        super.init(children: [], view: view)
        view.backgroundColor = Color.white()
    }

    func onItemClick(item: SidebarItem) {
        if let menu = menu {
            Actions().navigate(menu, toKey: item.key)
        }
    }

    func updateMenuItems() {
        if menu == nil { return }
        if children.count > 0 { return }
        children = menu!.items.map() { menuItem in
            let item = SidebarItem()
            item.key = menuItem.key
            item.text = menuItem.label
            item.image = NSImage(named: item.text)
            item.onMouseDown = { [weak self] in
                self?.onItemClick(item)
            }
            return item
        }
    }

    override func render() {
        let menu: NavigationStore.Menu! = self.menu
        if menu == nil { return }

        var column = view!.bounds.rectByInsetting(dx: 0, dy: topMargin).extend(right: SidebarItem.rightBleed)
        var rows = column.rows()

        for child in children as! [SidebarItem] {
            child.isSelected = child.key == menu.selected?.key

            if child.key == "inbox" && inboxCount > 0 {
                child.badge = String(inboxCount)
            }

            if child.key == "settings" {
                child.frame = CGRectMake(0, bounds.height, bounds.width + 16, rowHeight).offset(dy: -rowHeight - spaceHeight)
                child.text = account?.name ?? "No account"
            } else {
                child.frame = rows.next(rowHeight)
            }

            if child.key == "compose" {
                rows.next(spaceHeight)
            }
        }
    }
    
}
