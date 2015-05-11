//
//  MainSidebar.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/28/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class SidebarData: DataComponent {

    private let sidebar = Sidebar()

    var folders: [MailFolder] = []
    var selectedFolder = ""

    init(children: [Component] = [], view: NSView? = nil, layer: CALayer? = nil) {
        super.init(
            stores: [Stores().mail, Stores().navigation],
            children: [sidebar]
        )

        sidebar.updateItem = { [weak self] (item, row, total) in
            self?.renderItem(item, row: row, total: total)
        }
        sidebar.onItemClick = { item in
            Actions().navigate(.MAIN, key: item.key)
        }
    }

    override func onStoreUpdate() {
        if let account = Stores().account.getActive() {
            folders = Stores().mail.getFolders(account)
            selectedFolder = Stores().navigation.getSelected(.MAIN)
        }
    }

    override func render() {
        sidebar.frame = frame
        sidebar.selectedItem = selectedFolder
        sidebar.itemCount = folders.count + 2
        sidebar.reloadItems()
    }

    private func renderItem(item: SidebarItem, row: Int, total: Int) {
        if row == 0 {
            item.key = "compose"
            item.text = "Compose"
            item.image = NSImage(named: "Compose")
            item.badge = ""
            item.topSpacer = false
            item.bottomMargin = true
            return
        }

        if row == total - 1 {
            item.key = "settings"
            item.text = "Settings"
            item.image = NSImage(named: "Settings")
            item.badge = ""
            item.topSpacer = true
            item.bottomMargin = false
            return
        }

        let folder = folders[row - 1]
        item.key = folder.name
        item.text = folder.name
        item.image = NSImage(named: folder.name)
        item.topSpacer = false
        item.bottomMargin = false

        if folder.numTotalMessages > 0 {
            item.badge = "\(folder.numTotalMessages)"
        } else {
            item.badge = ""
        }
    }

}