//
//  SidebarComponent.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/6/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
//

import Cocoa

class SidebarComponent: Component {

    override func render() -> Component {
        return View(props: [
            "frame": self.props["frame"]!,
            "backgroundColor": self.props["color"]!,
        ])
    }
    
}
