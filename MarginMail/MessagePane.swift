//
//  MessagePane.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/25/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class MessagePane: Component {

    var message: MailMessage?

    init() {
        let view = View()
        view.backgroundColor = Color.white()

        super.init(children: [], view: view)
    }

    override func render() {
    }
}
