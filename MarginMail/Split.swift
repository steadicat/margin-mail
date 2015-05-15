//
//  Split.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/25/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class Split: Component {

    // TODO: make this private
    let split: SplitView

    init(id: String, children: [Component], minimumSizes: [Int: CGFloat] = [:], maximumSizes: [Int: CGFloat] = [:]) {
        split = SplitView(frame: CGRectZero, minimumSizes: minimumSizes, maximumSizes: maximumSizes)
        super.init(children: children, view: split)
        assert(split.subviews.count > 1, "Split views should have at least two child views")
        
        split.identifier = id
        split.autosaveName = id
        split.onResize = self.onResize
        self.onResize()
    }

    var dividerThickness: CGFloat {
        get {
            return split.dividerThickness
        }
    }

    override func render() {
    }

    func onResize() {
        for i in 0...(children.count-1) {
            children[i].frame = split.subviews[i].frame
        }
        needsUpdate = true
    }
}
