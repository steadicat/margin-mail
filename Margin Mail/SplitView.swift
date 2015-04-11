//
//  SplitView.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/6/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
//

import Cocoa

class SplitView: Component, NSSplitViewDelegate {
    
    var frame: CGRect
    var maximumSizes: [Int: CGFloat]
    
    init(frame: CGRect, maximumSizes: [Int: CGFloat] = [:], children: [Component?] = []) {
        self.frame = frame
        self.maximumSizes = maximumSizes
        super.init(children: children)
    }
    
    override func render() -> Component {
        return self
    }
    
    override func renderToView(lastView: NSView?, lastRender: Component?) -> NSView {
        var view = lastView != nil ? lastView as! NSSplitView : NSSplitView(frame: self.frame)
        view.delegate = self
        
        if self.frame != (self.lastRender as? SplitView)?.frame {
            view.frame = self.frame
        }
        
        view.vertical = true
        view.dividerStyle = .Thin
        
        self.renderChildren(view, children: self.children, lastChildren: lastRender != nil ? lastRender!.children : [])
        
        return view
    }
    
    func splitView(splitView: NSSplitView, constrainMaxCoordinate proposedMaximumPosition: CGFloat, ofSubviewAt dividerIndex: Int) -> CGFloat {
        return self.maximumSizes[dividerIndex] ?? proposedMaximumPosition
    }
}
