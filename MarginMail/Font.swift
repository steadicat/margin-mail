//
//  Font.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 5/11/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class Font {

    static var normal = {
        return NSFont(name: "OpenSans", size: 14)
    }()

    static var strong = {
        return NSFont(name: "OpenSans-Semibold", size: 14)
    }()

    static var small = {
        return NSFont(name: "OpenSans", size: 11)
    }()

}