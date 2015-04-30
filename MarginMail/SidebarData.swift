//
//  SidebarData.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/28/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class SidebarData: DataComponent {

    private let sidebar = Sidebar()

    private var items: [NavigationStore.Item] = [] {
        didSet {
            needsUpdate = true
        }
    }

    private var selected: NavigationStore.Item? {
        didSet {
            needsUpdate = true
        }
    }

    private var inboxCount = 0 {
        didSet {
            needsUpdate = true
        }
    }

    init(children: [Component] = [], view: NSView? = nil, layer: CALayer? = nil) {
        super.init(
            stores: [Stores().account, Stores().message, Stores().navigation],
            children: [sidebar]
        )
        sidebar.updateItem = { [weak self] (index, item) in
            return self?.updateItem(index, item: item)
        }
        sidebar.onItemClick = { [weak self] item in
            Actions().navigateMainMenu(item.key)
        }
    }

    override func onStoreUpdate() {
        if let account = Stores().account.getActive() {
            inboxCount = Stores().message.getMessageCount(account)
        }
        items = Stores().navigation.getMainMenuItems()
        selected = Stores().navigation.selectedMainMenuItem
    }

    override func render() {
        sidebar.frame = frame
        sidebar.selectedItem = selected?.key ?? ""
        sidebar.numberOfItems = items.count
        sidebar.reloadItems()
    }

    private func updateItem(index: Int, item: SidebarItem) -> Sidebar.Position? {
        if index >= items.count {
            return nil
        }

        let menuItem = items[index]
        item.isSelected = menuItem.key == selected?.key

        item.key = menuItem.key
        item.text = menuItem.label
        item.image = NSImage(named: item.text)

        if item.key == "inbox" && inboxCount > 0 {
            item.badge = String(inboxCount)
        } else {
            item.badge = ""
        }

        if item.key == "compose" {
            return .DIVIDER
        }
        if item.key == "settings" {
            return .BOTTOM
        }
        return nil
    }

}