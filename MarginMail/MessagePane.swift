//
//  MessagePane.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/25/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class MessagePane: Component {

    init() {
        let view = View()
        super.init(view: view)

        view.backgroundColor = Color.accent()
    }

    override func render() {
        println("render MessagePane with \(bounds)")
    }
}
