//
//  Main.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/6/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class Main: View, NSSplitViewDelegate {

    private var split: SplitView
    private var sidebar: Sidebar
    private var content: Content

    override init(frame: CGRect) {
        split = SplitView(frame: frame, minimumSizes: [0: Sidebar.minimumWidth], maximumSizes: [0: Sidebar.maximumWidth])

        let columns = frame.columns()
        sidebar = Sidebar(frame: columns.next(Sidebar.maximumWidth))
        columns.next(split.dividerThickness)
        content = Content(frame: columns.nextFraction(1))

        super.init(frame: frame)

        split.addSubview(sidebar)
        split.addSubview(content)
        addSubview(split)

        backgroundColor = Color.white()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillDraw() {
        split.frame = bounds
        super.viewWillDraw()
    }

}
