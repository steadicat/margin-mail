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

    override init() {
        split = SplitView(frame: CGRectZero, minimumSizes: [0: Sidebar.minimumWidth], maximumSizes: [0: Sidebar.maximumWidth])
        sidebar = Sidebar(frame: CGRectZero)
        content = Content()

        super.init()

        split.addSubview(sidebar)
        if let subview = content.view {
            split.addSubview(subview)
        }

        sidebar.backgroundColor = Color.white()

        split.identifier = "mainSplitView"
        split.autosaveName = "mainSplitView"

        if CGRectIsEmpty(sidebar.frame) {
            let columns = bounds.columns()
            sidebar.frame = columns.next(Sidebar.maximumWidth)
            columns.next(split.dividerThickness)
            content.frame = columns.nextFraction(1)
        }
    }

    func render() {
        content.render()
        split.frame = bounds
    }

    var view: NSView? {
        get {
            return split
        }
    }

}
