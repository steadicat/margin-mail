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
            self.needsDisplay = true
            self.needsLayout = true
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
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillDraw() {
        var rows = bounds.rectByInsetting(dx: 24, dy: 6).rows()

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
