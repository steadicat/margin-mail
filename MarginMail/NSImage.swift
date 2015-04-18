//
//  NSImage.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/10/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa
import SQLite

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

extension NSImage: SQLite.Value {

    public class var declaredDatatype: String {
        return NSData.declaredDatatype
    }

    public class func fromDatatypeValue(blobValue: Blob) -> Self {
        return self(data: NSData.fromDatatypeValue(blobValue))!
    }

    public var datatypeValue: Blob {
        return self.TIFFRepresentation!.datatypeValue
    }
    
}
