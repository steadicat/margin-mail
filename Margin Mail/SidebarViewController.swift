//
//  SidebarViewController.swift
//  Margin Mail
//
//  Created by Stefano J. Attardi on 4/5/15.
//  Copyright (c) 2015 Stefano J. Attardi. All rights reserved.
//

import Cocoa

class SidebarViewController: NSViewController {

    var tableView: NSTableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame = CGRectMake(0, 0, 700, 700)
        self.view.bounds = CGRectMake(0.0, 0.0, 700.0, 700.0)
        
        self.tableView = NSTableView(frame: CGRectZero)
        self.view.addSubview(tableView!)
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        
        self.tableView!.frame = self.view.bounds;
    }
    
}
