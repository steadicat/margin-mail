//
//  SidebarItem.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/11/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class SidebarItem: Component {

    static let rightBleed: CGFloat = 16
    private let iconGap: CGFloat = 12

    var isSelected: Bool = false
    var image: NSImage?
    var text: String = ""
    var badge: String = ""

    var onMouseDown: (() -> ())?

    private var isHovered: Bool = false {
        didSet {
            needsUpdate = true
        }
    }

    private var itemView = View()
    private var label = Label()
    private var badgeLayer = TextLayer()
    private var icon = ImageView(frame: CGRectZero)

    init() {
        itemView.wantsLayer = true

        super.init(children: [label], view: itemView)

        itemView.addSubview(icon)
        itemView.layer!.addSublayer(badgeLayer)

        itemView.onMouseEnter = mouseEnter
        itemView.onMouseExit = mouseExit
        itemView.onMouseDown = mouseDown
    }

    func mouseEnter() {
        isHovered = true
    }

    func mouseExit() {
        isHovered = false
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

        let columns = bounds.extend(right: -SidebarItem.rightBleed).columns()
        columns.next(sideMargin)
        if let image = self.image {
            self.icon.frame = columns.next(24).integerRect
            self.icon.image = image.tintedImageWithColor(textColor)
        } else {
            columns.next(24)
        }
        columns.next(iconGap)

        label.frame = columns.nextFraction(1).integerRect.offset(dx: isSelected ? -0.5 : 0, dy: 9)
        label.text = text
        label.font = isSelected ? Font.semibold : Font.normal
        label.textColor = textColor

        badgeLayer.frame = columns.next(24).offset(dx: -24, dy: 12)
        badgeLayer.string = badge
        badgeLayer.font = Font.small
        badgeLayer.foregroundColor = textColor.CGColor

        itemView.backgroundColor = (isHovered ? Color.accent(1) : Color.white())

        self.fadeLabel(bounds.width > 120)
    }

    func fadeLabel(visible: Bool) {
        label.layer!.opacity = visible ? 1 : 0
        /*
        var anim = label.layer!.pop_animationForKey("fade") as! POPSpringAnimation?
        if anim == nil {
            anim = POPSpringAnimation(propertyNamed: kPOPLayerOpacity)
            label.layer!.pop_addAnimation(anim, forKey: "fade")
        }
        anim!.toValue = visible ? 1 : 0
        */
    }

    func popOnClick() {
        var anim = label.layer!.pop_animationForKey("scaleXY") as! POPSpringAnimation?
        var shift: POPSpringAnimation?
        if anim == nil {
            anim = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
            layer!.pop_addAnimation(anim, forKey: "scaleXY")

            shift = POPSpringAnimation(propertyNamed: kPOPLayerTranslationXY)
            layer!.pop_addAnimation(shift, forKey: "shift")
        }
        anim!.velocity = NSValue(size: CGSizeMake(-2, -2))
        anim!.toValue = NSValue(size: CGSizeMake(1, 1))
        shift!.velocity = NSValue(size: CGSizeMake(120, 36))
        shift!.toValue = NSValue(size: CGSizeMake(0, 0))
    }

}
