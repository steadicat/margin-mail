//
//  Main.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/6/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
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
        self.addSubview(split)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillDraw() {
        self.split.frame = self.frame
        self.sidebar.color = self.sidebarColor

        let columns = self.frame.rectsByCols([216, 0.5, 0.5])
        self.sidebar.frame = columns[0]
        self.messageList.frame = columns[1]
        self.messagePane.frame = columns[2]
        
        super.viewWillDraw()
    }
    
}
