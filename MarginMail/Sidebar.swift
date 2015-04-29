//
//  Sidebar.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/6/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class Sidebar: Component {

    enum Position {
        case DIVIDER
        case BOTTOM
    }

    static let minimumWidth: CGFloat = 66
    static let maximumWidth: CGFloat = 216

    var numberOfItems = 0

    var selectedItem: String = "" {
        didSet {
            needsUpdate = true
        }
    }

    var onItemClick: ((SidebarItem) -> ())?
    var updateItem: ((index: Int, item: SidebarItem) -> Position?)?

    private let topMargin: CGFloat = 36
    private let spaceHeight: CGFloat = 18
    private let rowHeight: CGFloat = 36

    init() {
        let view = View(frame: CGRectZero)
        super.init(children: [], view: view)
        view.backgroundColor = Color.white()
    }

    func reloadItems() {
        // Once child view handling works as expected in the base component,
        // we can fill `children` with missing items.
        if children.count > 0 { return }

        children = (0..<numberOfItems).map() { index in
            let item = SidebarItem()
            item.onMouseDown = { [weak self] in
                self?.onItemClick?(item)
            }
            return item
        }
    }

    override func render() {
        var column = view!.bounds.rectByInsetting(dx: 0, dy: topMargin).extend(right: SidebarItem.rightBleed)
        var rows = column.rows()

        for (index, item) in enumerate(children) {
            let position = updateItem?(index: index, item: item as! SidebarItem)

            if position == .BOTTOM {
                item.frame = CGRectMake(0, bounds.height, bounds.width + 16, rowHeight).offset(dy: -rowHeight - spaceHeight)
            } else {
                item.frame = rows.next(rowHeight)
            }

            if position == .DIVIDER {
                rows.next(spaceHeight)
            }
        }
    }
    
}
