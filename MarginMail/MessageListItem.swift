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

    let authorLabel: TextLayer
    let subjectLabel: TextLayer
    let snippetLabel: TextLayer

    let borderLayer: CALayer

    override init(frame frameRect: NSRect) {
        borderLayer = CALayer()

        authorLabel = TextLayer()
        authorLabel.font = NSFont(name: "OpenSans-Semibold", size: 14)
        authorLabel.foregroundColor = Color.darkGray().CGColor

        subjectLabel = TextLayer()
        subjectLabel.font = NSFont(name: "OpenSans", size: 14)
        subjectLabel.foregroundColor = Color.darkGray().CGColor

        snippetLabel = TextLayer()
        snippetLabel.font = NSFont(name: "OpenSans", size: 11)
        snippetLabel.foregroundColor = Color.mediumGray().CGColor
        snippetLabel.wrapped = true

        super.init(frame: frameRect)

        wantsLayer = true
        layer?.addSublayer(authorLabel)
        layer?.addSublayer(subjectLabel)
        layer?.addSublayer(snippetLabel)
        layer?.addSublayer(borderLayer)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillDraw() {
        var rows = bounds.rectByInsetting(dx: 24, dy: 6).rows()

        authorLabel.string = author
        authorLabel.font = NSFont(name: seen ? "OpenSans" : "OpenSans-Semibold", size: 14)
        authorLabel.frame = rows.next(authorLabel.heightForSize(rows.remaining))

        subjectLabel.string = subject
        subjectLabel.frame = rows.next(subjectLabel.heightForSize(rows.remaining))

        snippetLabel.string = snippet
        snippetLabel.frame = rows.next(rows.remaining.height)

        borderLayer.frame = selected ? Rect(0, 0, 3, bounds.height) : CGRectZero
        borderLayer.backgroundColor = Color.accent().CGColor

        super.viewWillDraw()
    }
}
