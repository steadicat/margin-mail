//
//  Color.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/17/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class Color {

    static let accentHue: CGFloat = 0.6

    static func white() -> NSColor {
        return NSColor.whiteColor()
    }

    static func accent() -> NSColor {
        return NSColor(hue: accentHue, chroma: 0.9, lightness: 0.9)
    }

    static func accent(lightness: CGFloat) -> NSColor {
        return NSColor(hue: accentHue + lightness / 100, saturation: 0.9, lightness: lightness)
    }

    static func darkGray() -> NSColor {
        return NSColor(white: 0.25, alpha: 1)
    }

    static func mediumGray() -> NSColor {
        return NSColor(white: 0.75, alpha: 1)
    }

    static func lightGray() -> NSColor {
        return NSColor(white: 0.9, alpha: 1)
    }
}
