//
//  SidebarComponent.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/6/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
//

import Cocoa

struct SidebarProps {
    var frame: NSRect
    var color: NSColor
}

class SidebarComponent: Component {

    var props: SidebarProps

    init(props: SidebarProps) {
        self.props = props
        super.init(children: [])
    }

    override func render() -> Component {
        return View(props: ViewProps(
            frame: self.props.frame,
            backgroundColor: self.props.color
        ))
    }
    
}