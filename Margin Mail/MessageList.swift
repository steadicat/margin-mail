//
//  MessageList.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/6/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class MessageList: View {
    
    var color: NSColor?
    
    private var text: TextField
    private var loadingText: TextField
    
    var isLoading: Bool = true {
        didSet {
            self.needsDisplay = true
        }
    }
    
    init(frame: CGRect, color: NSColor? = nil) {
        self.color = color
        text = TextField(frame: CGRectZero)
        loadingText = TextField(frame: CGRectZero)
        loadingText.text = "Loading..."
        
        super.init(frame: frame)
        
        self.addSubview(text)
        self.addSubview(loadingText)
        
        weak var weakSelf = self
        
        var time = dispatch_time(DISPATCH_TIME_NOW, Int64(8 * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue(), { weakSelf?.isLoading = false })
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillDraw() {
        backgroundColor = self.color
        text.frame = self.frame.rectByCentering(Size(80, 20), offset: Point(0, -20))
        loadingText.frame = self.frame.rectByCentering(Size(80, 20), offset: Point(0, 20))
        loadingText.alphaValue = self.isLoading ? 1 : 0
        
        super.viewWillDraw()
    }

}
