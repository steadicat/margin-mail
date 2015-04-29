//
//  Sidebar.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/6/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class Sidebar: Component {

    static let minimumWidth: CGFloat = 66
    static let maximumWidth: CGFloat = 216

    var numberOfItems = 0

    var selectedItem: String = "" {
        didSet {
            needsUpdate = true
        }
    }

    var onItemClick: ((SidebarItem) -> ())?
    var createItem: ((Int) -> SidebarItem)?

    private let topMargin: CGFloat = 36
    private let spaceHeight: CGFloat = 18
    private let rowHeight: CGFloat = 36

    private var items: [String: SidebarItem] = [:]

    init() {
        let view = View(frame: CGRectZero)
        super.init(children: [], view: view)
        view.backgroundColor = Color.white()
    }

    func getItem(key: String) -> SidebarItem? {
        return items[key]
    }

    func reloadItems() {
        // The early return is temporary. We need to avoid re-creating sidebar
        // items that have already been created.
        if children.count > 0 { return }
        if createItem == nil { return }

        children = (0..<numberOfItems).map() { index in
            let item = self.createItem!(index)
            item.onMouseDown = { [weak self] in
                self?.onItemClick?(item)
            }
            self.items[item.key] = item
            return item
        }
    }

    override func render() {
        var column = view!.bounds.rectByInsetting(dx: 0, dy: topMargin).extend(right: SidebarItem.rightBleed)
        var rows = column.rows()

        for child in children as! [SidebarItem] {
            child.isSelected = child.key == selectedItem

            if child.key == "settings" {
                child.frame = CGRectMake(0, bounds.height, bounds.width + 16, rowHeight).offset(dy: -rowHeight - spaceHeight)
            } else {
                child.frame = rows.next(rowHeight)
            }

            if child.key == "compose" {
                rows.next(spaceHeight)
            }
        }
    }
    
}
