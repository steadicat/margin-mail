//
//  MessageList.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/6/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class MessageList: DataComponent {

    private let scroll: ScrollView
    private let table: TableView

    private var selectedRow = 0
    private var isLoading = false
    private var hasLoaded = false

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
        return [stores.account, stores.message]
    }

    override func getDataFromStores(stores: Stores) {
        let account: Account! = stores.account.getActive()
        if account == nil {
            return
        }

        if !hasLoaded {
            hasLoaded = true
            Registry().actions.loadMessages(account)
            return
        }

        isLoading = stores.message.isLoading()
        messages = stores.message.getMessages(account)
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
