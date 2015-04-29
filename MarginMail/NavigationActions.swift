//
//  NavigationActions.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/28/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

extension MainActions {

    struct NavigateMain: Action {
        let key: String
    }

    func navigateMain(key: String) {
        dispatch(NavigateMain(key: key))
    }

}