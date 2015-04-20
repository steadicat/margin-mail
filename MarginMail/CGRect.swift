//
//  CGRect.swift
//  MarginMail
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

    func offset(dx: CGFloat = 0, dy: CGFloat = 0) -> CGRect {
        return self.rectByOffsetting(dx: dx, dy: dy)
    }

    func resize(width: CGFloat? = nil, height: CGFloat? = nil) -> CGRect {
        return CGRectMake(self.origin.x, self.origin.y, width ?? self.width, height ?? self.height)
    }

    func extend(top: CGFloat = 0, right: CGFloat = 0, bottom: CGFloat = 0, left: CGFloat = 0) -> CGRect {
        return CGRectMake(self.origin.x - left, self.origin.y - top, self.width + left + right, self.height + top + bottom)
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
        var rect = CGRect(x: frame.origin.x, y: y, width: frame.width, height: height)
        y += height
        return rect
    }

    func nextFraction(var height: CGFloat) -> CGRect {
        assert(height <= 1, "Fractions should be less than 1")
        return next((frame.height - y) * height)
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
        var rect = CGRect(x: x, y: frame.origin.y, width: width, height: frame.height)
        x += width
        return rect
    }

    func nextFraction(var width: CGFloat) -> CGRect {
        assert(width <= 1, "Fractions should be less than 1")
        return next((frame.width - x) * width)
    }
}
