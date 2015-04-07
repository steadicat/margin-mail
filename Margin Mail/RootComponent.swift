//
//  RootComponent.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/6/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
//

import Cocoa

class RootComponent: Component {

    override func render() -> Component {
        var frame = self.props["frame"]!.rectValue
        
        return View(
            props: ["frame": self.props["frame"]!],
            children: [
                SidebarComponent(props: [
                    "frame": NSValue(rect: CGRectMake(0, 0, 216, frame.height)),
                    "color": self.props["sidebarColor"]!,
                ]),
                MessageListComponent(props: [
                    "frame": NSValue(rect: CGRectMake(216, 0, frame.width - 216, frame.height))
                ]),
            ]
        )
    }
    
}
