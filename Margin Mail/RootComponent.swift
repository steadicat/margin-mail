//
//  RootComponent.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/6/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
//

import Cocoa

class RootComponent: Component {

    var frame: CGRect

    var _sidebarColor: NSColor
    var sidebarColor: NSColor {
        get {
            return self._sidebarColor
        }
        set(color) {
            self._sidebarColor = color
            self.needsRender()
        }
    }
    
    var _isLoading: Bool
    var isLoading: Bool {
        get {
            return self._isLoading
        }
        set(isLoading) {
            self._isLoading = isLoading
            self.needsRender()
        }
    }
    
    init(frame: CGRect, sidebarColor: NSColor, isLoading: Bool, children: [Component] = []) {
        self.frame = frame
        self._sidebarColor = sidebarColor
        self._isLoading = isLoading
        super.init(children: children)
    }
    
    override func render() -> Component {
        return SplitView(
            frame: self.frame,
            children: [
                SidebarComponent(
                    frame: CGRectMake(0, 0, 216, frame.height),
                    color: self.sidebarColor
                ),
                MessageListComponent(
                    frame: CGRectMake(216, 0, frame.width - 216, frame.height),
                    color: NSColor.orangeColor(),
                    showLoading: self.isLoading
                ),
            ]
        )
    }
    
}
