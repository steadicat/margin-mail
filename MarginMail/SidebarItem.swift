//
//  SidebarItem.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/11/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class SidebarItemView: View {

    private let iconGap: CGFloat = 12

    var accentColor: NSColor = Color.accent() {
        didSet {
            self.needsDisplay = true
        }
    }

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

    var badge: String = "" {
        didSet {
            label.text = "\(text) (\(badge))"
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

        label.opaque = true

        addSubview(label)
        addSubview(icon)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillDraw() {

        let collapsingRatio = (frame.width - Sidebar.minimumWidth) / (Sidebar.maximumWidth - Sidebar.minimumWidth)
        let sideMargin = 18 + round(18 * collapsingRatio)

        let textColor = isSelected ? self.accentColor : Color.darkGray()

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

        backgroundColor = isHovered ? Color.accent(1) : Color.white()

        assert(label.opaque, "Label should be opaque for proper text rendering while animating")
        self.fadeLabel(bounds.width > 120)

        super.viewWillDraw()
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
        assert(wantsLayer, "Needs a layer to animate")
        var anim = label.pop_animationForKey("scaleXY") as! POPSpringAnimation?
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

    override func mouseEntered(theEvent: NSEvent) {
        self.isHovered = true
        super.mouseEntered(theEvent)
    }

    override func mouseExited(theEvent: NSEvent) {
        self.isHovered = false
        super.mouseExited(theEvent)
    }

    override func mouseDown(theEvent: NSEvent) {
        popOnClick()
        super.mouseDown(theEvent)
    }
    
}
