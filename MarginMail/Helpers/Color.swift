//
//  Color.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/11/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class Color {

    static let accentHue: CGFloat = 0.62

    static func white() -> NSColor {
        return NSColor.whiteColor()
    }

    static func accent() -> NSColor {
        return NSColor(hue: accentHue, chroma: 0.9, lightness: 0.7)
    }

    static func accent(lightness: CGFloat) -> NSColor {
        return NSColor(hue: accentHue, saturation: 0.05, lightness: 0.99)
    }

    static func darkGray() -> NSColor {
        return NSColor(white: 0.5, alpha: 1)
    }

    static func mediumGray() -> NSColor {
        return NSColor(white: 0.75, alpha: 1)
    }

    static func lightGray() -> NSColor {
        return NSColor(white: 0.9, alpha: 1)
    }
}
