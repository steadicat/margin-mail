//
//  View.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/6/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class View: NSView {

    var backgroundColor: NSColor? {
        didSet {
            self.needsDisplay = true
        }
    }
    
    lazy private var caLayer = CALayer()

    override var flipped: Bool {
        get {
            return true
        }
    }
    
    override func viewWillDraw() {
    
        if let backgroundColor = self.backgroundColor {
            if !self.wantsLayer {
                self.wantsLayer = true;
                self.layer = self.caLayer
            }
            self.layer!.backgroundColor = backgroundColor.CGColor;
        } else {
            self.wantsLayer = false
            self.layer = nil
        }
        
        super.viewWillDraw()

    }
    
}
