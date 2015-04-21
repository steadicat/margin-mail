//
//  MessageList.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/6/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class MessageList: View {

    let scroll: ScrollView
    let table: TableView

    private var selectedRow = 0

    override init(frame frameRect: NSRect) {
        scroll = ScrollView(frame: CGRectZero)

        table = TableView(frame: CGRectZero)

        super.init(frame: frameRect)

        table.headerView = nil
        table.rowHeight = 96
        table.rows = 100
        table.columns = 1
        table.createCell = self.createCell
        table.updateCell = self.updateCell
        table.onRowSelect = self.onRowSelect

        scroll.documentView = table
        addSubview(scroll)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillDraw() {
        scroll.frame = bounds
        super.viewWillDraw()
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

    func getNumberOfRows() -> Int {
        return 12
    }

    func createCell() -> NSView {
        return MessageListItem(frame: CGRectZero)
    }

    func updateCell(#column: Int, row: Int, view: NSView) -> NSView {
        if let message = view as? MessageListItem {
            message.selected = row == self.selectedRow
            message.author = "Stefano J. Attardi"
            message.subject = "Hi Artem, how are things?"
            message.snippet = "I dunno why I’m writing. I guess I just wanted to test this new awesome email client. It’s pretty sweet I guess. I especially like text wrapping and text truncation."
        }
        return view
    }

}
