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
            // TODO: figure out why this one needs to be layout instead of display
            self.needsLayout = true
        }
    }
    
    var image: NSImage? {
        didSet {
            self.needsDisplay = true
        }
    }
    
    var text: String = "" {
        didSet {
            label.text = text
        }
    }
    
    private var isHovered: Bool = false {
        didSet {
            self.needsDisplay = true
        }
    }
    
    private var label: Label
    private var icon: ImageView
    
    override init(frame: CGRect) {
        label = Label(frame: CGRectZero)
        icon = ImageView(frame: CGRectZero)
        
        super.init(frame: frame)

        addSubview(label)
        addSubview(icon)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillDraw() {
        let collapsedWidth = 66 as CGFloat
        let maximumWidth = 216 as CGFloat
        let iconGap = 12 as CGFloat
        
        let collapsingRatio = (frame.width - collapsedWidth) / (maximumWidth - collapsedWidth)
        let sideMargin = 22 + round(14 * collapsingRatio)
        
        let textColor = isSelected ? Color.accent() : Color.mediumGray()

        let columns = bounds.columns()
        columns.next(sideMargin)
        if let image = self.image {
            self.icon.frame = columns.next(24)
            self.icon.image = image.tintedImageWithColor(textColor)
        } else {
            columns.next(24)
        }
        columns.next(iconGap)
        label.frame = columns.next(1).integerRect.offset(dy: 5)
        label.font = NSFont(name: (isSelected ? "OpenSans-Semibold" : "OpenSans"), size: 14)
        label.textColor = textColor
        
        backgroundColor = isHovered ? NSColor(white: 0, alpha: 0.02) : NSColor.clearColor()

        var anim = label.pop_animationForKey("alphaValue") as! POPSpringAnimation?
        if anim == nil {
            anim = POPSpringAnimation(propertyNamed: kPOPViewAlphaValue)
            label.pop_addAnimation(anim, forKey: "alphaValue")
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
