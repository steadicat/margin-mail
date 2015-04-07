//
//  RootComponent.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/6/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
//

import Cocoa

class RootComponent: Component {

    override func render() -> NSView {
        var frame = self.props["frame"]!.rectValue
        
        var view = NSView(frame: frame)
        
        var leftView = SidebarComponent(props: [
            "frame": NSValue(rect: CGRectMake(0, 0, 216, frame.height)),
            "color": self.props["sidebarColor"]!,
        ])
        view.addSubview(leftView.render())
        
        var rightView = MessageListComponent(props: [
            "frame": NSValue(rect: CGRectMake(216, 0, frame.width - 216, frame.height))
        ])
        view.addSubview(rightView.render())
        
        return view
    }
    
}
