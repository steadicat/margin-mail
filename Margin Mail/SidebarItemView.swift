//
//  SidebarItemView.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/11/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
//

import Cocoa

class SidebarItemView: Button {

    var isHovered: Bool = false
    var isSelected: Bool = false
    
    override func viewWillDraw() {
        let sideMargin = 36 as CGFloat

        textColor = isSelected ? NSColor(hue: 0.56, saturation: 1.0, brightness: 1.0, alpha: 1.0) : NSColor(white: 0.3, alpha: 1)
        backgroundColor = isHovered ? NSColor(hue: 0.56, saturation: 0.05, brightness: 1.0, alpha: 1.0) : nil
        bordered = false
        font = NSFont(name: (isSelected ? "OpenSans-Semibold" : "OpenSans"), size: 14)
        leftMargin = sideMargin
        
        super.viewWillDraw()
    }
    
}
