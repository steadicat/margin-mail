//
//  SplitView.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/6/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
//

import Cocoa

class SplitView: NSSplitView, NSSplitViewDelegate {
    
    var maximumSizes: [Int: CGFloat]
    
    init(frame: CGRect, maximumSizes: [Int: CGFloat] = [:]) {
        self.maximumSizes = maximumSizes
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillDraw() {
        self.delegate = self
        
        self.vertical = true
        self.dividerStyle = .Thin
        
        super.viewWillDraw()
    }
    
    func splitView(splitView: NSSplitView, constrainMaxCoordinate proposedMaximumPosition: CGFloat, ofSubviewAt dividerIndex: Int) -> CGFloat {
        return self.maximumSizes[dividerIndex] ?? proposedMaximumPosition
    }
}
