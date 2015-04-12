//
//  Main.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/6/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class Main: View, NSSplitViewDelegate {
    
    private var split: SplitView
    private var sidebar: Sidebar
    private var messageList: MessageList
    private var messagePane: View
    
    private var closeButton: NSButton
    private var miniaturizeButton: NSButton
    private var zoomButton: NSButton

    override init(frame: CGRect) {
        split = SplitView(frame: frame, minimumSizes: [0: 56], maximumSizes: [0: 216])
        sidebar = Sidebar(frame: CGRectZero)
        messageList = MessageList(frame: CGRectZero)
        messagePane = View(frame: CGRectZero)
        
        closeButton = NSWindow.standardWindowButton(.CloseButton, forStyleMask: NSTitledWindowMask)!
        miniaturizeButton = NSWindow.standardWindowButton(.MiniaturizeButton, forStyleMask: NSTitledWindowMask)!
        zoomButton = NSWindow.standardWindowButton(.ZoomButton, forStyleMask: NSTitledWindowMask)!
        
        super.init(frame: frame)
        
        split.addSubview(sidebar)
        split.addSubview(messageList)
        split.addSubview(messagePane)
        
        let columns = self.bounds.columns()
        self.sidebar.frame = columns.next(216)
        self.messageList.frame = columns.next(0.5)
        self.messagePane.frame = columns.next(1)
        
        addSubview(split)
        
        closeButton.frame = CGRect(center: Point(12, 12), size: closeButton.frame.size)
        miniaturizeButton.frame = CGRect(center: Point(32, 12), size: miniaturizeButton.frame.size)
        zoomButton.frame = CGRect(center: Point(52, 12), size: zoomButton.frame.size)
        addSubview(closeButton)
        addSubview(miniaturizeButton)
        addSubview(zoomButton)

        self.wantsLayer = true
        self.layer = CALayer()
        self.layer!.delegate = self
        self.layer!.backgroundColor = Color.white().CGColor
        self.layer!.cornerRadius = 8
        
        weak var weakSelf = self
        split.onResize = { weakSelf?.onSplitResize() }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillDraw() {
        self.split.frame = self.frame
        super.viewWillDraw()
    }
    
    func onSplitResize() {
    }
}
