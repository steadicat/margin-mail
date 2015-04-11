//
//  Color.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/11/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
//

import Cocoa

let accentHue: CGFloat = 0.56

class Color {
    
    static func white() -> NSColor {
        return NSColor.whiteColor()
    }
    
    static func accent() -> NSColor {
        return NSColor(hue: accentHue, saturation: 1, brightness: 1, alpha: 1)
    }
    
    static func accent(lightness: CGFloat) -> NSColor {
        return NSColor(hue: accentHue + lightness / 100, saturation: 1 - lightness, brightness: 1, alpha: 1)
    }
    
    static func mediumGray() -> NSColor {
        return NSColor(white: 0.3, alpha: 1)
    }
    
}
