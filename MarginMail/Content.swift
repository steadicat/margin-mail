//
//  Content.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/19/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class Content: View {

    private var split: SplitView
    private var messageList: MessageList
    private var messagePane: View

    override init(frame: CGRect) {
        split = SplitView(frame: frame)
        messageList = MessageList(frame: CGRectZero)
        messagePane = View(frame: CGRectZero)

        super.init(frame: frame)

        split.addSubview(messageList)
        split.addSubview(messagePane)

        addSubview(split)

        split.frame = bounds
        let columns = bounds.columns()
        messageList.frame = columns.nextFraction(0.5)
        columns.next(split.dividerThickness)
        messagePane.frame = columns.nextFraction(1)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillDraw() {
        split.frame = bounds
        super.viewWillDraw()
    }
}
