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

    private var menu: NavigationStore.Menu? {
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
            Actions().navigateMain(toKey: item.key)
        }
    }

    override func onStoreUpdate() {
        if let account = Stores().account.getActive() {
            inboxCount = Stores().message.getMessageCount(account)
        }
        menu = Stores().navigation.getMainMenu()
    }

    override func render() {
        sidebar.frame = frame
        sidebar.selectedItem = menu?.selected?.key ?? ""
        sidebar.numberOfItems = menu?.items.count ?? 0
        sidebar.reloadItems()
    }

    private func updateItem(index: Int, item: SidebarItem) -> Sidebar.Position? {
        if let menu = self.menu, let menuItem = self.menu?.items[index] {
            item.isSelected = item.key == menu.selected?.key
            item.key = menuItem.key
            item.text = menuItem.label
            item.image = NSImage(named: item.text)

            if item.key == "inbox" {
                item.badge = inboxCount > 0 ? String(inboxCount) : ""
            }
            if item.key == "compose" {
                return .DIVIDER
            }
            if item.key == "settings" {
                return .BOTTOM
            }
        }
        return nil
    }

}