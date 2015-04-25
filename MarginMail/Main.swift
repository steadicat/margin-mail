//
//  Main.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/6/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class Main: Component {

    private let split: SplitView
    private let sidebar: Sidebar
    private let content: Content

    init() {
        split = SplitView(frame: CGRectZero, minimumSizes: [0: Sidebar.minimumWidth], maximumSizes: [0: Sidebar.maximumWidth])
        sidebar = Sidebar()
        content = Content()

        super.init(children: [sidebar, content], view: split)

        split.identifier = "mainSplitView"
        split.autosaveName = "mainSplitView"
    }

    override func render() {
        //split.frame = bounds

        if CGRectIsEmpty(sidebar.frame) || CGRectIsEmpty(content.view!.frame) {
            let columns = bounds.columns()
            sidebar.frame = columns.next(Sidebar.maximumWidth)
            columns.next(split.dividerThickness)
            content.frame = columns.nextFraction(1)
        }
    }

}
