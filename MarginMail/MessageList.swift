//
//  MessageList.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/6/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class MessageList: Component {

    private let scroll: ScrollView
    private let table: TableView

    private var selectedRow = 0

    private var messages: [MailMessage] = [] {
        didSet {
            self.needsUpdate = true
        }
    }

    init() {
        scroll = ScrollView(frame: CGRectZero)
        table = TableView(frame: CGRectZero)

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

    override func getStoresToWatch(stores: Stores) -> [Store] {
        return [stores.account]
    }

    override func getDataFromStores(stores: Stores) {
        // XXX: This will go into a message store and async will be handled
        // using multiple action dispatches.
        if let account = stores.account.getActive() {
            account.client.getMessages() { messages in
                self.messages = messages
            }
        }
    }

    override func render() {
        table.rows = messages.count
        table.reloadData()
    }

    func onRowSelect(row: Int) {
        if let row = table.rowViewAtRow(selectedRow, makeIfNecessary: false) as? NSTableRowView {
            for view in row.subviews {
                (view as? MessageListItem)?.selected = false
            }
        }
        selectedRow = row
        if let row = table.rowViewAtRow(row, makeIfNecessary: false) as? NSTableRowView {
            for view in row.subviews {
                (view as? MessageListItem)?.selected = true
            }
        }
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
            item.snippet = message.body
        }
        return view
    }

}
