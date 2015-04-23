//
//  Component.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/22/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class Component: NSObject {
    var frame: CGRect = CGRectZero {
        didSet {
            self.render()
        }
    }

    var bounds: CGRect {
        get {
            return Rect(0, 0, frame.width, frame.height)
        }
    }

    func render() {
        assertionFailure("Components must implement render()")
    }
}