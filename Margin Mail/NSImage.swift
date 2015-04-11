//
//  NSImage.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/10/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

extension NSImage {
    
    func tintedImageWithColor(tint: NSColor) -> NSImage {
        var imageBounds = NSMakeRect(0, 0, self.size.width, self.size.height);
        var copiedImage = self.copy() as! NSImage
        copiedImage.lockFocus()
        tint.set()
        NSRectFillUsingOperation(imageBounds, .CompositeSourceAtop)
        copiedImage.unlockFocus()
        return copiedImage
    }
    
}
