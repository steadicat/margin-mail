//
//  MainContent.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/19/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class MainContent: DataComponent {

    let empty: Component = {
        let view = View()
        return Component(view: view)
    }()

    private var contents: [String: Component] = [:]

    private var selected: String = "" {
        didSet {
            updateContent(selected)
        }
    }

    init() {
        let view = View()
        super.init(
            stores: [Stores().navigation],
            children: [empty],
            view: view
        )
        view.backgroundColor = NSColor.whiteColor()
    }

    func updateContent(key: String) {
        if contents[key] == nil, let content = createContent(key) {
            contents[key] = content
        }
        if let component = contents[key] {
            children = [component]
        } else {
            children = [empty]
        }
    }

    override func onStoreUpdate() {
        selected = Stores().navigation.selectedMainMenuItem?.key ?? ""
    }

    override func render() {
        view?.hidden = true
        renderContent(selected, component: contents[selected] ?? empty)
        view?.hidden = false
    }

    private func renderContent(key: String, component: Component) {
        switch(key) {
        case "inbox":
            let split = component as! Split
            let columns = bounds.columns()

            split.children[0].frame = columns.nextFraction(0.5)
            columns.next(split.dividerThickness)

            split.children[1].frame = columns.nextFraction(1)
            split.view!.frame = bounds

        default:
            component.view?.frame = bounds
        }
    }

    private func createContent(key: String) -> Component? {
        switch (key) {
        case "inbox":
            let list = MessageListData()
            let pane = MessagePane()
            return Split(id: "contentSplitView", children: [list, pane])

        default:
            return nil
        }
    }

}
