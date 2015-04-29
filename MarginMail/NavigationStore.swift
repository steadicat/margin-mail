//
//  NavigationStore.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/28/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

class NavigationStore: Store {

    struct Item {
        let key: String
        let label: String
        let visible: Bool
        init(_ key: String, label: String) {
            self.key = key
            self.label = label
            self.visible = true
        }
    }

    struct Menu {

        let items: [Item]
        var selected: Item?

        private var itemsByKey: [String: Item] = [:]

        init (_ items: [Item]) {
            self.items = items
            for item in items { itemsByKey[item.key] = item }
            selected = nil
        }

        subscript(key: String) -> Item? {
            return itemsByKey[key]
        }
    }

    private var mainMenu = Menu([
        Item("compose", label: "Compose"),
        Item("inbox", label: "Inbox"),
        Item("archive", label: "Archive"),
        Item("drafts", label: "Drafts"),
        Item("sent", label: "Sent"),
        Item("starred", label: "Starred"),
        Item("spam", label: "Spam"),
        Item("trash", label: "Trash"),
        Item("settings", label: "Settings"),
    ])

    override func handleAction(action: Action) {
        switch (action) {
        case let action as MainActions.NavigateMain:
            if let item = mainMenu[action.key] {
                mainMenu.selected = item
            }
            notify()
        default:
            break
        }
    }

}

extension NavigationStore {

    func getMainMenuItems() -> [Item] {
        return mainMenu.items
    }

    func getSelectedMainMenuItem() -> Item? {
        return mainMenu.selected
    }

}