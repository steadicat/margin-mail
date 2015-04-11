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

    func rectByRow(size: CGSize, index: Int, offset: CGPoint = CGPointZero) -> CGRect {
        return CGRectMake(
            0,
            offset.y + (size.height * CGFloat(index)),
            size.width == 0 ? self.width : size.width,
            size.height == 0 ? self.height : size.height
        )
    }

    func rectsByCols(cols: [CGFloat]) -> [CGRect] {
        var whole = self.width - cols.filter({ $0 >= 1 }).reduce(0, combine: +)
        var rects: [CGRect] = cols.map() {
            var width = $0 < 1 ? whole * $0 : $0
            return CGRectMake(0, 0, width, self.height)
        }
        assert(rects.count == cols.count, "CGRect count matches column count")
        return rects
    }

}