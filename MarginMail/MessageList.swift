//
//  MessageList.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/6/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class MessageList: Component {


    var isLoading = false {
        didSet {
            needsUpdate = true
        }
    }

    var messages: [MailMessage] = [] {
        didSet {
            needsUpdate = true
        }
    }

    private var selectedRow = 0

    private let scroll = ScrollView(frame: CGRectZero)
    private let table = TableView(frame: CGRectZero)

    init() {
        super.init(children: [], view: scroll)

        table.headerView = nil
        table.rowHeight = 96
        table.rows = 0
        table.columns = 1
        table.createCell = self.createCell
        table.updateCell = self.updateCell
        table.onRowSelect = self.onRowSelect

        scroll.documentView = table
    }

    override func render() {
        if isLoading {
            // Display a loader
        } else {
            table.rows = messages.count
            table.reloadData()
        }
    }

    func onRowSelect(row: Int) {
        selectedRow = row
        needsUpdate = true
    }

    func createCell() -> NSView {
        return MessageListItem(frame: CGRectZero)
    }

    func updateCell(#column: Int, row: Int, view: NSView) -> NSView {
        if let item = view as? MessageListItem {
            let message = messages[row]
            item.selected = row == self.selectedRow
            item.author = message.sender.name ?? "<no name>"
            item.subject = message.subject
            item.snippet = message.body?.text ?? ""
        }
        return view
    }

}
