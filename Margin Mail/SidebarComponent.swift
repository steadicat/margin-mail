//
//  SidebarComponent.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/6/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
//

import Cocoa

class SidebarComponent: Component {

    override func render() -> NSView {
        var frame = self.props["frame"]!.rectValue
        
        var view = NSView(frame: frame)
        
        view.layer = CALayer()
        view.wantsLayer = true
        view.layer!.backgroundColor = (self.props["color"]!.nonretainedObjectValue as! NSColor).CGColor
        
        return view
    }
    
}
