//
//  RootComponent.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/6/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
//

import Cocoa

class RootComponent: Component {

    var frame: CGRect {
        didSet {
            self.needsRender()
        }
    }

    var sidebarColor: NSColor {
        didSet {
            self.needsRender()
        }
    }

    init(frame: CGRect, sidebarColor: NSColor, children: [Component?] = []) {
        self.frame = frame
        self.sidebarColor = sidebarColor
        super.init(children: children)
    }
    
    override func render() -> Component {
        return SplitView(
            frame: self.frame,
            maximumSizes: [0: 216],
            children: [
                SidebarComponent(
                    frame: CGRectMake(0, 0, 216, frame.height),
                    color: self.sidebarColor
                ),
                MessageListComponent(
                    frame: CGRectMake(0, 0, (frame.width - 216) / 2, frame.height)
                ),
                View(
                    frame: CGRectMake(0, 0, (frame.width - 216) / 2, frame.height)
                )
            ]
        )
    }
    
}
