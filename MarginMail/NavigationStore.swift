//
//  NavigationStore.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/28/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

class NavigationStore: Store {

    typealias Menu = Navigation.Menu
    typealias Item = Navigation.Item

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
        case let action as MainActions.NavigateMainMenu:
            mainMenu.select(action.key)
            notify()
        case let action as MainActions.HideMainMenuItem:
            mainMenu.hide(action.key)
            notify()
        case let action as MainActions.ShowMainMenuItem:
            mainMenu.show(action.key)
            notify()
        default:
            break
        }
    }

}

extension NavigationStore {

    var selectedMainMenuItem: Item? {
        return mainMenu.selected
    }

    func getMainMenuKeys() -> [String] {
        return mainMenu.keys()
    }

    func getMainMenuItems() -> [Item] {
        return mainMenu.items.filter() { item in
            return item.visible
        }
    }

}