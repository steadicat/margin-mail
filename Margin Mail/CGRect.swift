//
//  CGRect.swift
//  Margin Mail
//
//  Created by Artem Nezvigin on 4/10/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
//

import Cocoa

extension CGRect {

    func rectByCenter(size: CGSize, offset: CGPoint = CGPointZero) -> CGRect {
        return CGRectMake(
            (self.width/2 - size.width/2) + offset.x,
            (self.height/2 - size.height/2) + offset.y,
            size.width,
            size.height
        )
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