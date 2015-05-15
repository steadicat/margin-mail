//
//  EmptyContent.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 5/10/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class EmptyContent: Component {

    private let empty = View()

    init() {
        super.init(view: empty)
    }

    override func render() {
        empty.frame = bounds
    }
}
