//
//  MainSidebar.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/28/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class MainSidebar: DataComponent {

    private let sidebar = Sidebar()

    private var items: [Navigation.Item] = [] {
        didSet {
            needsUpdate = true
        }
    }

    private var selected: Navigation.Item? {
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
            stores: [Stores().account, Stores().mail, Stores().navigation],
            children: [sidebar]
        )
        sidebar.onItemClick = { [weak self] item in
            Actions().navigateMainMenu(item.key)
        }
    }

    override func onStoreUpdate() {
        if let account = Stores().account.getActive() {
//            inboxCount = Stores().message.getMessageCount(account)
        }
        items = Stores().navigation.getMainMenuItems()
        selected = Stores().navigation.selectedMainMenuItem
    }

    override func render() {
        sidebar.frame = frame
        sidebar.selectedItem = selected?.key ?? ""
        sidebar.items = items
    }

}