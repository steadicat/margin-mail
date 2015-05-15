//
//  Label.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/17/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class Label: Component {

    enum Alignment {
        case Natural
        case Left
        case Right
        case Center
        case Justified
    }

    var text: NSString = ""
    var font: NSFont?
    var textColor: NSColor?
    var alignment: Alignment = .Natural

    private var textLayer = TextLayer()

    init() {
        super.init(layer: textLayer)
    }

    override func render() {
        Layer.withoutAnimations {
            self.textLayer.frame = self.frame
            self.textLayer.string = self.text
            if let font = self.font {
                self.textLayer.font = font
            }
            self.textLayer.foregroundColor = self.textColor?.CGColor
            self.textLayer.alignmentMode = alignmentMode(alignment)
        }
    }

    private func alignmentMode(alignment: Alignment) -> String {
        switch alignment {
        case .Natural: return kCAAlignmentNatural
        case .Left: return kCAAlignmentLeft
        case .Right: return kCAAlignmentRight
        case .Center: return kCAAlignmentCenter
        case .Justified: return kCAAlignmentJustified
        }
    }
}
