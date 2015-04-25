//
//  SplitView.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/17/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class SplitView: NSSplitView, NSSplitViewDelegate {

    var minimumSizes: [Int: CGFloat]
    var maximumSizes: [Int: CGFloat]
    var onResize: (() -> ())?

    init(frame: CGRect, minimumSizes: [Int: CGFloat] = [:], maximumSizes: [Int: CGFloat] = [:]) {
        self.minimumSizes = minimumSizes
        self.maximumSizes = maximumSizes
        super.init(frame: frame)

        delegate = self
        vertical = true
        dividerStyle = .Thin
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var _opaque: Bool = true

    override var opaque: Bool {
        get {
            return _opaque
        }
        set(value) {
            _opaque = value
        }
    }

    override func viewWillDraw() {
        super.viewWillDraw()
    }

    func splitView(splitView: NSSplitView, constrainMaxCoordinate proposedMaximumPosition: CGFloat, ofSubviewAt dividerIndex: Int) -> CGFloat {
        return self.maximumSizes[dividerIndex] ?? proposedMaximumPosition
    }

    func splitView(splitView: NSSplitView, constrainMinCoordinate proposedMinimumPosition: CGFloat, ofSubviewAt dividerIndex: Int) -> CGFloat {
        return self.minimumSizes[dividerIndex] ?? proposedMinimumPosition
    }

    override func resizeSubviewsWithOldSize(oldSize: NSSize) {
        assert(subviews.count > 1, "SplitView should have at least two subviews")

        // TODO: make this work with vertical split views as well
        let columns = bounds.columns()

        for index in 0...(subviews.count - 2) {
            if let subview = subviews[index] as? NSView {
                subview.frame = columns.next(subview.frame.width)
                columns.next(self.dividerThickness)
            }
        }
        if let last = subviews.last as? NSView {
            last.frame = columns.nextFraction(1)
        }
    }

    func splitViewDidResizeSubviews(notification: NSNotification) {
        self.onResize?()
    }

}
