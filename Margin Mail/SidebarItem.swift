//
//  SidebarItem.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/11/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class SidebarItemView: Button {

    var sideMargin: CGFloat = 0
    var isSelected: Bool = false
    
    private var isHovered: Bool = false {
        didSet {
            self.needsDisplay = true
        }
    }
    
    override func viewWillDraw() {
        let sideMargin = self.sideMargin + 36

        textColor = isSelected ? Color.accent() : Color.mediumGray()
        backgroundColor = isHovered ? Color.accent(0.95) : nil
        bordered = false
        font = NSFont(name: (isSelected ? "OpenSans-Semibold" : "OpenSans"), size: 14)
        leftMargin = sideMargin
        
        super.viewWillDraw()
    }
    
    override func mouseEntered(theEvent: NSEvent) {
        self.isHovered = true
        super.mouseEntered(theEvent)
    }
    
    override func mouseExited(theEvent: NSEvent) {
        self.isHovered = false
        super.mouseExited(theEvent)
    }
    
}
