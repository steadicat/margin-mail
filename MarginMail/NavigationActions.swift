//
//  NavigationActions.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/28/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

extension MainActions {

    struct Navigate: Action {
        let menu: NavigationStore.Menu
        let key: String
    }

    func navigate(menu: NavigationStore.Menu, toKey key: String) {
        dispatch(Navigate(menu: menu, key: key))
    }

}