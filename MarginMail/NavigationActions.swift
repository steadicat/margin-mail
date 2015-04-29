//
//  NavigationActions.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/28/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

extension MainActions {

    struct NavigateMainMenu: Action {
        let key: String
    }

    struct ShowMainMenuItem: Action {
        let key: String
    }

    struct HideMainMenuItem: Action {
        let key: String
    }

    func navigateMainMenu(key: String) {
        dispatch(NavigateMainMenu(key: key))
    }

    func showMainMenuItem(key: String) {
        dispatch(ShowMainMenuItem(key: key))
    }

    func hideMainMenuItem(key: String) {
        dispatch(HideMainMenuItem(key: key))
    }

}