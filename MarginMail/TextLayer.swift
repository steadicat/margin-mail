//
//  TextLayer.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/20/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class TextLayer: CATextLayer {

    override var font: AnyObject! {
        get {
            return super.font
        }
        set(font) {
            assert(font != nil, "There will be no setting a nil font on my watch")
            super.font = font
            super.fontSize = font.pointSize
        }
    }

    override init!(layer: AnyObject!) {
        super.init(layer: layer)
    }

    override init() {
        super.init()
        contentsScale = NSScreen.mainScreen()!.backingScaleFactor
        truncationMode = kCATruncationEnd
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func sizeThatFits(size: CGSize) -> CGRect {
        return (string as! NSString).boundingRectWithSize(size,
            options: wrapped ? (.UsesLineFragmentOrigin) : nil,
            attributes: getAttributes()
        )
    }

    func heightForSize(size: CGSize) -> CGFloat {
        return sizeThatFits(size).height
    }

    private func getAttributes() -> [String: AnyObject] {
        return [
            NSFontAttributeName: self.font as? NSFont ?? NSFont.systemFontOfSize(NSFont.systemFontSize())
        ]
    }
}
