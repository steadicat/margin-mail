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
        
        let sidebarSize: CGFloat = 216
        
        self.sidebar.frame = CGRectMake(0, 0, sidebarSize, self.frame.height)
        self.sidebar.color = self.sidebarColor
        
        self.messageList.frame = CGRectMake(0, 0, (self.frame.width - sidebarSize) / 2, self.frame.height)
        self.messagePane.frame = CGRectMake(0, 0, (self.frame.width - sidebarSize) / 2, self.frame.height)
        
        super.viewWillDraw()
    }
    
}
