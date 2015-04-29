//
//  Main.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/6/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class Main: Component {

    private let split: Split
    private let sidebar = SidebarData()
    private let content = Content()

    init() {
        split = Split(id: "mainSplitView", children: [sidebar, content], minimumSizes: [0: Sidebar.minimumWidth], maximumSizes: [0: Sidebar.maximumWidth])
        super.init(children: [split])
    }

    override func render() {
        if CGRectIsEmpty(sidebar.frame) || CGRectIsEmpty(content.view!.frame) {
            let columns = bounds.columns()
            sidebar.frame = columns.next(Sidebar.maximumWidth)
            columns.next(split.dividerThickness)
            content.frame = columns.nextFraction(1)
        }
    }

}
