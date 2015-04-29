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
        sidebar.createItem = { [weak self] index in
            return self?.createSidebarItem(index) ?? SidebarItem()
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

        if let item = sidebar.getItem("inbox") {
            item.badge = inboxCount > 0 ? String(inboxCount) : ""
        }
    }

    private func createSidebarItem(index: Int) -> SidebarItem? {
        if let menuItem = self.menu?.items[index] {
            let item = SidebarItem()
            item.key = menuItem.key
            item.text = menuItem.label
            item.image = NSImage(named: item.text)
            return item
        }
        return nil
    }

}