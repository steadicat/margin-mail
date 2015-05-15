//
//  Color.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/11/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class Color {

    static let accentHue: CGFloat = 0.66

    static func transparent() -> NSColor {
        return NSColor(white: 0, alpha: 0)
    }

    static func white() -> NSColor {
        return NSColor.whiteColor()
    }

    static func accent() -> NSColor {
        return NSColor(hue: accentHue, chroma: 0.95, lightness: 0.65)
    }

    static func accent(lightness: CGFloat) -> NSColor {
        return NSColor(hue: accentHue, saturation: 0.05, lightness: 0.99)
    }

    static func darkGray() -> NSColor {
        return NSColor(white: 0.25, alpha: 1)
    }

    static func mediumGray() -> NSColor {
        return NSColor(white: 0.5, alpha: 1)
    }

    static func lightGray() -> NSColor {
        return NSColor(white: 0.75, alpha: 1)
    }

    static func random(saturation: CGFloat = 0.9, lightness: CGFloat = 0.65) -> NSColor {
        return NSColor(hue: CGFloat(arc4random()) / CGFloat(UINT32_MAX), saturation: saturation, lightness: lightness)
    }
}
