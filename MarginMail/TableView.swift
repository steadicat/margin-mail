//
//  TableView.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/20/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class TableView: NSTableView, NSTableViewDataSource, NSTableViewDelegate {

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setDelegate(self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var columns: Int {
        get {
            return super.numberOfColumns
        }
        set(n) {
            for i in super.numberOfColumns...(n-1) {
                addTableColumn(NSTableColumn())
            }
        }
    }
    var rows: Int = 0 {
        didSet {
            setDataSource(self)
        }
    }

    var createCell: (() -> NSView)?
    var updateCell: ((column: Int, row: Int, view: NSView) -> NSView)?

    var created = 0

    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        println("numberOfRows \(rows)")
        return rows
    }

    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {

        var view = tableView.makeViewWithIdentifier("tableViewCell", owner:self) as? NSView
        println("creating view? \(view) \(self.createCell)")
        if view == nil && self.createCell != nil {
            println("creating view \(created++)")
            view = self.createCell!()
            view!.identifier = "tableViewCell"
        }
        return self.updateCell?(column: 0, row: row, view: view!)
    }

}
