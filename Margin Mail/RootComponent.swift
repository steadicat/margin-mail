//
//  RootComponent.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/6/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
//

import Cocoa

struct RootProps {
    var frame: NSRect
    var sidebarColor: NSColor
}

class RootComponent: Component {

    var props: RootProps

    init(props: RootProps) {
        self.props = props
        super.init(children: [])
    }

    override func render() -> Component {
        var frame = self.props.frame
        
        return SplitView(
            props: SplitViewProps(frame: self.props.frame),
            children: [
                SidebarComponent(props: SidebarProps(
                    frame: CGRectMake(0, 0, 216, frame.height),
                    color: self.props.sidebarColor
                )),
                MessageListComponent(props: MessageListProps(
                    frame: CGRectMake(216, 0, frame.width - 216, frame.height),
                    backgroundColor: nil
                )),
            ]
        )
    }
    
}
