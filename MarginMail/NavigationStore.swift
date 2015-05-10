//
//  NavigationStore.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/28/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

class NavigationStore: Store {

    enum Menu {
        case MAIN
    }

    private var selected: [Menu: String] = [:]

    override func handleAction(action: Action) {
        switch (action) {
        case let action as MainActions.Navigate:
            selected[action.menu] = action.key
            notify()
        default:
            break
        }
    }

}

extension NavigationStore {

    func getSelected(menu: Menu) -> String {
        return selected[menu] ?? ""
    }

}