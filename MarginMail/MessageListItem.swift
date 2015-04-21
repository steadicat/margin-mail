//
//  MessageListItem.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/20/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class MessageListItem: View {

    var author: String = ""
    var subject: String = ""
    var snippet: String = ""
    var selected: Bool = false {
        didSet {
            self.needsDisplay = true
            self.needsLayout = true
        }
    }

    let authorLabel: Label
    let subjectLabel: Label
    let snippetLabel: Label

    let borderLayer: CALayer

    override init(frame frameRect: NSRect) {
        authorLabel = Label(frame: CGRectZero)
        authorLabel.font = NSFont(name: "OpenSans-Semibold", size: 14)
        authorLabel.textColor = Color.darkGray()

        borderLayer = CALayer()

        subjectLabel = Label(frame: CGRectZero)
        subjectLabel.font = NSFont(name: "OpenSans", size: 14)
        subjectLabel.textColor = Color.darkGray()

        snippetLabel = Label(frame: CGRectZero)
        snippetLabel.font = NSFont(name: "OpenSans", size: 11)
        snippetLabel.textColor = Color.mediumGray()

        super.init(frame: frameRect)

        addSubview(authorLabel)
        addSubview(subjectLabel)
        addSubview(snippetLabel)

        wantsLayer = true
        layer?.addSublayer(borderLayer)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillDraw() {
        var rows = bounds.rectByInsetting(dx: 24, dy: 12).rows()

        authorLabel.text = author
        authorLabel.sizeToFit()
        authorLabel.frame = rows.next(authorLabel.frame.height).integerRect

        subjectLabel.text = subject
        subjectLabel.sizeToFit()
        subjectLabel.frame = rows.next(subjectLabel.frame.height).integerRect

        snippetLabel.text = snippet
        snippetLabel.sizeToFit()
        snippetLabel.frame = rows.next(snippetLabel.frame.height).integerRect

        borderLayer.frame = selected ? Rect(0, 0, 3, bounds.height) : CGRectZero
        borderLayer.backgroundColor = Color.accent().CGColor

        super.viewWillDraw()
    }
}
