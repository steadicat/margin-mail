//
//  Store.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/20/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

class Store {

    init() {
        Dispatcher.register(self, self.action)
    }

    deinit {
        Dispatcher.dispose(self)
    }

    func action(action: Any) {}

}
