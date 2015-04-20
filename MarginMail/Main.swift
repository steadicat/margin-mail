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
        sidebar = Sidebar(frame: CGRectZero)
        content = Content(frame: CGRectZero)

        super.init(frame: frame)

        split.addSubview(sidebar)
        split.addSubview(content)

        let columns = self.bounds.columns()
        self.sidebar.frame = columns.next(Sidebar.maximumWidth)
        self.content.frame = columns.next(1)

        addSubview(split)

        backgroundColor = Color.white()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillDraw() {
        self.split.frame = self.frame
        super.viewWillDraw()
    }
    
}
