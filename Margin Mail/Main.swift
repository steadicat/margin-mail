//
//  Main.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/6/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class Main: View {

    var sidebarColor: NSColor? {
        didSet {
            self.needsDisplay = true
        }
    }
    
    private var split: SplitView
    private var sidebar: Sidebar
    private var messageList: MessageList
    private var messagePane: View

    override init(frame: CGRect) {
        split = SplitView(frame: frame, maximumSizes: [0: 216])
        sidebar = Sidebar(frame: CGRectZero)
        sidebar.color = self.sidebarColor
        messageList = MessageList(frame: CGRectZero)
        messagePane = View(frame: CGRectZero)
        
        super.init(frame: frame)
        
        split.addSubview(sidebar)
        split.addSubview(messageList)
        split.addSubview(messagePane)
        
        let columns = self.bounds.columns()
        self.sidebar.frame = columns.next(216)
        self.messageList.frame = columns.next(0.5)
        self.messagePane.frame = columns.next(1)
        
        self.addSubview(split)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillDraw() {
        self.split.frame = self.frame
        self.sidebar.color = self.sidebarColor
        super.viewWillDraw()
    }
    
}
