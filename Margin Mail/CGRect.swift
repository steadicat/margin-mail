//
//  CGRect.swift
//  Margin Mail
//
//  Created by Artem Nezvigin on 4/10/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

extension CGRect {

    var center: CGPoint {
        get {
            return CGPointMake(CGRectGetMidX(self), CGRectGetMidY(self))
        }
    }

    init(center: CGPoint, size: CGSize) {
        self.init(x: center.x - size.width / 2, y: center.y - size.height / 2, width: size.width, height: size.height)
    }
    
    func offset(dx: CGFloat, _ dy: CGFloat) -> CGRect {
        return self.rectByOffsetting(dx: dx, dy: dy)
    }
    
    func rows() -> RowGenerator {
        return RowGenerator(frame: self)
    }
    
    func columns() -> ColumnGenerator {
        return ColumnGenerator(frame: self)
    }
}


class RowGenerator {
    let frame: CGRect
    var y: CGFloat
    
    init(frame: CGRect) {
        self.frame = frame
        self.y = frame.origin.y
    }
    
    func next(var height: CGFloat) -> CGRect {
        if height <= 1 {
            height = (frame.height - y) * height
        }
        var rect = CGRect(x: frame.origin.x, y: y, width: frame.width, height: height)
        y += height
        return rect
    }
}

class ColumnGenerator {
    let frame: CGRect
    var x: CGFloat
    
    init(frame: CGRect) {
        self.frame = frame
        self.x = frame.origin.x
    }
    
    func next(var width: CGFloat) -> CGRect {
        if width <= 1 {
            width = (frame.width - x) * width
        }
        var rect = CGRect(x: x, y: frame.origin.y, width: width, height: frame.height)
        x += width
        return rect
    }
}
