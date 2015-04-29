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
    private var hasLoaded = false

    init(children: [Component] = [], view: NSView? = nil, layer: CALayer? = nil) {
        super.init(
            stores: [Stores().account, Stores().message, Stores().navigation],
            children: [sidebar]
        )
    }

    override func onStoreUpdate() {
        let account = Stores().account.getActive()
        sidebar.account = account
        sidebar.inboxCount = account == nil ? 0 : Stores().message.getMessages(account!).count
        sidebar.menu = Stores().navigation.getMainMenu()
    }

    override func render() {
        sidebar.frame = frame
    }

}