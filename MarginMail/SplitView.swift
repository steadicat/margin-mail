//
//  SplitView.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/17/15.
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
        self.delegate = self

        self.vertical = true
        self.dividerStyle = .Thin

        super.viewWillDraw()
    }

    func splitView(splitView: NSSplitView, constrainMaxCoordinate proposedMaximumPosition: CGFloat, ofSubviewAt dividerIndex: Int) -> CGFloat {
        return self.maximumSizes[dividerIndex] ?? proposedMaximumPosition
    }

    func splitView(splitView: NSSplitView, constrainMinCoordinate proposedMinimumPosition: CGFloat, ofSubviewAt dividerIndex: Int) -> CGFloat {
        return self.minimumSizes[dividerIndex] ?? proposedMinimumPosition
    }

    func splitViewDidResizeSubviews(notification: NSNotification) {
        self.onResize?()
    }

}
