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

    private let topMargin: CGFloat = 36
    private let spaceHeight: CGFloat = 18
    private let rowHeight: CGFloat = 36

    var folders: [MailFolder] = []
    var selectedItem: String = ""

    private var composeItem = SidebarItem()
    private var folderItems: [SidebarItem] = []
    private var settingsItem = SidebarItem()

    var updateItem: ((SidebarItem, Int, Int) -> Void)?
    var onItemClick: ((SidebarItem) -> Void)?

    init() {
        let view = View(frame: CGRectZero)
        view.backgroundColor = Color.white()

        super.init(children: [composeItem, settingsItem], view: view)

        composeItem.key = "compose"
        composeItem.text = "Compose"
        composeItem.image = NSImage(named: "Compose")
        composeItem.onMouseDown = { [weak self] in
            self?.onItemClick?(composeItem)
        }

        settingsItem.key = "settings"
        settingsItem.text = "Settings"
        settingsItem.image = NSImage(named: "Settings")
        settingsItem.onMouseDown = { [weak self] in
            self?.onItemClick?(settingsItem)
        }
    }

    override func render() {
        let column = view!.bounds.extend(right: SidebarItem.rightBleed)
        let rows = column.rows()
        rows.next(topMargin)

        composeItem.isSelected = composeItem.key == selectedItem
        composeItem.frame = rows.next(rowHeight)

        rows.next(spaceHeight)

        var newFolderItems = [] as [SidebarItem]
        for (i, folder) in enumerate(folders) {
            newFolderItems.append(renderFolder(i < folderItems.count ? folderItems[i] : nil, folder: folder, rows: rows))
        }
        folderItems = newFolderItems

        rows.nextFraction(1)

        settingsItem.isSelected = settingsItem.key == selectedItem
        settingsItem.frame = rows.next(rowHeight).offset(dy: -rowHeight - spaceHeight)

        children = [composeItem] + folderItems + [settingsItem]
    }

    private func renderFolder(var item: SidebarItem!, folder: MailFolder, rows: RowGenerator) -> SidebarItem {
        if item == nil {
            item = SidebarItem()
            item.onMouseDown = { [weak self] in
                self?.onItemClick?(item)
            }
            item.key = folder.name
            item.text = folder.name
            item.image = NSImage(named: folder.name)
        }

        if folder.type == .DRAFTS {
            item.badge = folder.numTotalMessages > 0 ? "\(folder.numTotalMessages)" : ""
        } else {
            item.badge = folder.numUnreadMessages > 0 ? "\(folder.numUnreadMessages)" : ""
        }

        item.isSelected = item.key == selectedItem
        item.frame = rows.next(rowHeight)

        return item
    }

}
