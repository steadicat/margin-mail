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
        sidebar.folders = folders
        sidebar.selectedItem = selectedFolder
    }

}