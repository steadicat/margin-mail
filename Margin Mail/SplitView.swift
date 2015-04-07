//
//  SplitView.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/6/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
//

import Cocoa

class SplitView: Component {
    
    override func renderToView() -> NSView {
        var view = NSSplitView(frame: self.props["frame"]!.rectValue)
        
        view.vertical = true
        
        for child in self.children {
            var renderedView = child.renderToView()
            view.addSubview(renderedView)
        }
        
        return view;
    }
    
}
