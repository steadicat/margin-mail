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
        sidebar.updateItem = { [weak self] (item, row) in
            self?.renderItem(item, row: row)
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
        sidebar.itemCount = folders.count
        sidebar.reloadItems()
    }

    private func renderItem(item: SidebarItem, row: Int) {
        let folder = folders[row]
        item.key = folder.name
        item.text = folder.name
        item.image = NSImage(named: folder.name)

        if folder.numTotalMessages > 0 {
            item.badge = "\(folder.numTotalMessages)"
        } else {
            item.badge = ""
        }
    }

}