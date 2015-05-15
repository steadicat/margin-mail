//
//  MessageListItem.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/20/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class MessageListItem: View {

    var author: NSString = ""
    var subject: NSString = ""
    var snippet: NSString = ""
    var seen: Bool = false

    var selected: Bool = false {
        didSet {
            needsDisplay = true
            needsLayout = true
        }
    }
    private var hovered: Bool = false {
        didSet {
            needsDisplay = true
            needsLayout = true
        }
    }

    let authorLabel = TextLayer()
    let subjectLabel = TextLayer()
    let snippetLabel = TextLayer()

    let borderLayer = CALayer()
    let unreadDotLayer = CALayer()

    override init(frame frameRect: NSRect) {
        authorLabel.font = Font.bold
        authorLabel.foregroundColor = Color.darkGray().CGColor

        subjectLabel.font = Font.normal
        subjectLabel.foregroundColor = Color.darkGray().CGColor

        snippetLabel.font = Font.small
        snippetLabel.foregroundColor = Color.mediumGray().CGColor
        snippetLabel.wrapped = true

        unreadDotLayer.cornerRadius = 3

        super.init(frame: frameRect)

        wantsLayer = true
        layer?.addSublayer(authorLabel)
        layer?.addSublayer(subjectLabel)
        layer?.addSublayer(snippetLabel)
        layer?.addSublayer(borderLayer)
        layer?.addSublayer(unreadDotLayer)

        onMouseEnter = mouseEnter
        onMouseExit = mouseExit
        onMouseDown = mouseDown
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func mouseEnter() {
        hovered = true
    }

    func mouseExit() {
        hovered = false
    }

    func mouseDown() {
        var scale = layer?.pop_animationForKey("scaleXY") as! POPSpringAnimation?
        var shift = layer?.pop_animationForKey("shift") as! POPSpringAnimation?
        if scale == nil {
            scale = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
            layer?.pop_addAnimation(scale, forKey: "scaleXY")
        }

        if shift == nil {
            shift = POPSpringAnimation(propertyNamed: kPOPLayerTranslationXY)
            layer?.pop_addAnimation(shift, forKey: "shift")
        }

        scale?.velocity = NSValue(size: CGSizeMake(-1.1, -1.1))
        scale?.toValue = NSValue(size: CGSizeMake(1, 1))

        shift?.velocity = NSValue(size: CGSizeMake(bounds.width / 2, bounds.height / 2))
        shift?.toValue = NSValue(size: CGSizeMake(0, 0))
    }

    override func viewWillDraw() {
        var rows = bounds.rectByInsetting(dx: 24, dy: 6).rows()

        backgroundColor = (hovered ? Color.accent(0.99) : Color.white())

        authorLabel.string = author
        authorLabel.frame = rows.next(authorLabel.heightForSize(rows.remaining))

        subjectLabel.string = subject
        subjectLabel.frame = rows.next(subjectLabel.heightForSize(rows.remaining))

        snippetLabel.string = snippet
        snippetLabel.frame = rows.next(rows.remaining.height)

        borderLayer.frame = Rect(0, 0, 3, bounds.height)
        borderLayer.backgroundColor = (selected ? Color.accent() : Color.transparent()).CGColor

        unreadDotLayer.frame = Rect(12, 38, 6, 6)
        unreadDotLayer.backgroundColor = (seen ? Color.transparent() : Color.accent()).CGColor

        super.viewWillDraw()
    }

}
