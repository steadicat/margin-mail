//
//  SidebarItem.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/11/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class SidebarItemView: View {

    var isSelected: Bool = false {
        didSet {
            self.needsDisplay = true
        }
    }
    
    var image: NSImage? {
        didSet {
            self.needsDisplay = true
        }
    }
    
    var text: String = "" {
        didSet {
            button.text = text
        }
    }
    
    private var isHovered: Bool = false {
        didSet {
            self.needsDisplay = true
        }
    }
    
    private var button: Button
    private var icon: ImageView
    
    override init(frame: CGRect) {
        button = Button(frame: CGRectZero)
        icon = ImageView(frame: CGRectZero)
        
        super.init(frame: frame)

        addSubview(button)
        addSubview(icon)
        
        weak var weakSelf = self
        button.onMouseDown = { weakSelf?.onMouseDown?() }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillDraw() {
        let collapsedWidth = 62 as CGFloat
        let maximumWidth = 216 as CGFloat
        let iconGap = 12 as CGFloat
        
        let collapsingRatio = (frame.width - collapsedWidth) / (maximumWidth - collapsedWidth)
        let sideMargin = 20 + cground(16 * collapsingRatio)
        
        let textColor = isSelected ? Color.accent() : Color.mediumGray()

        let columns = bounds.columns()
        columns.next(sideMargin)
        if image != nil {
            self.icon.frame = columns.next(24)
            self.icon.image = NSImage(named: "Inbox")?.tintedImageWithColor(textColor)
        } else {
            columns.next(24)
        }
        columns.next(iconGap)
        button.frame = columns.next(1).round()
        
        button.textColor = textColor
        
        backgroundColor = isHovered ? Color.accent(0.95) : NSColor.clearColor()

        button.bordered = false
        button.font = NSFont(name: (isSelected ? "OpenSans-Semibold" : "OpenSans"), size: 14)
        
        var anim = button.pop_animationForKey("alphaValue") as! POPSpringAnimation?
        if anim == nil {
            anim = POPSpringAnimation(propertyNamed: kPOPViewAlphaValue)
            button.pop_addAnimation(anim, forKey: "alphaValue")
        }
        anim!.toValue = self.bounds.width < 120 ? 0 : 1
        
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
