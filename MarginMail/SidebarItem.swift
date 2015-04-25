//
//  SidebarItem.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/11/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class SidebarItem: Component {

    private let iconGap: CGFloat = 12

    var isSelected: Bool = false {
        didSet {
            self.needsUpdate = true
        }
    }

    var image: NSImage? {
        didSet {
            self.needsUpdate = true
        }
    }

    var text: String = "" {
        didSet {
            label.text = text
        }
    }

    var badge: String = "" {
        didSet {
            label.text = "\(text) (\(badge))"
        }
    }

    var onMouseDown: (() -> ())?

    private var isHovered: Bool = false {
        didSet {
            self.needsUpdate = true
        }
    }

    private var itemView = View()
    private var label = Label(frame: CGRectZero)
    private var icon = ImageView(frame: CGRectZero)
    private var layer: CALayer

    init() {
        itemView.wantsLayer = true
        layer = itemView.layer!

        super.init(view: itemView)

        itemView.addSubview(label)
        itemView.addSubview(icon)
        itemView.onMouseEnter = mouseEnter
        itemView.onMouseExit = mouseExit
        itemView.onMouseDown = mouseDown
    }

    func mouseEnter() {
        self.isHovered = true
    }

    func mouseExit() {
        self.isHovered = false
    }

    func mouseDown() {
        popOnClick()
        onMouseDown?()
    }

    override func render() {
        itemView.frame = frame

        let collapsingRatio = (frame.width - Sidebar.minimumWidth) / (Sidebar.maximumWidth - Sidebar.minimumWidth)
        let sideMargin = 18 + round(18 * collapsingRatio)

        let textColor = isSelected ? Color.accent() : Color.mediumGray()

        // Add some overflow for shrink animation
        let columns = bounds.columns()
        columns.next(sideMargin)
        if let image = self.image {
            self.icon.frame = columns.next(24).integerRect
            self.icon.image = image.tintedImageWithColor(textColor)
        } else {
            columns.next(24)
        }
        columns.next(iconGap)
        label.frame = columns.nextFraction(1).integerRect.offset(dx: isSelected ? -1 : 0, dy: 5)
        label.font = NSFont(name: (isSelected ? "OpenSans-Semibold" : "OpenSans"), size: 14)
        label.textColor = textColor

        layer.backgroundColor = (isHovered ? Color.accent(1) : Color.white()).CGColor

        self.fadeLabel(bounds.width > 120)
    }

    func fadeLabel(visible: Bool) {
        var anim = label.pop_animationForKey("fade") as! POPSpringAnimation?
        if anim == nil {
            anim = POPSpringAnimation(propertyNamed: kPOPViewAlphaValue)
            label.pop_addAnimation(anim, forKey: "fade")
        }
        anim!.toValue = visible ? 1 : 0
    }

    func popOnClick() {
        var anim = label.pop_animationForKey("scaleXY") as! POPSpringAnimation?
        var shift: POPSpringAnimation?
        if anim == nil {
            anim = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
            layer.pop_addAnimation(anim, forKey: "scaleXY")

            shift = POPSpringAnimation(propertyNamed: kPOPLayerTranslationXY)
            layer.pop_addAnimation(shift, forKey: "shift")
        }
        anim!.velocity = NSValue(size: CGSizeMake(-2, -2))
        anim!.toValue = NSValue(size: CGSizeMake(1, 1))
        shift!.velocity = NSValue(size: CGSizeMake(120, 36))
        shift!.toValue = NSValue(size: CGSizeMake(0, 0))
    }

}
