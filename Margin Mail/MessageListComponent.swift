//
//  MessageListComponent.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/6/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
//

import Cocoa

class MessageListComponent: Component {
    
    var frame: CGRect
    var color: NSColor
    
    private var isLoading: Bool = true {
        didSet {
            self.needsRender()
        }
    }
    
    init(frame: CGRect, color: NSColor, children: [Component] = []) {
        self.frame = frame
        self.color = color
        super.init(children: children)
        
        var time = dispatch_time(DISPATCH_TIME_NOW, Int64(8 * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            self.isLoading = false
        }
    }
    
    override func render() -> Component {
        return View(
            frame: self.frame,
            backgroundColor: self.color,
            children: self.isLoading ? [
                TextField(frame: CGRectMake(self.frame.width / 2 - 40, self.frame.height / 2 - 60, 80, 20)),
                TextField(frame: CGRectMake(self.frame.width / 2 - 40, self.frame.height / 2 - 10, 80, 20), text: "Loading...")
            ] : [
                TextField(frame: CGRectMake(self.frame.width / 2 - 40, self.frame.height / 2 - 60, 80, 20)),
            ]
        )
    }
    
}
