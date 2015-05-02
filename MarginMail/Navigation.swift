//
//  Navigation.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/29/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

class Navigation {

    struct Item {

        let key: String
        let label: String
        let visible: Bool

        init(_ key: String, label: String, visible: Bool = true) {
            self.key = key
            self.label = label
            self.visible = visible
        }

        private mutating func show() {
            self = Item(key, label: label, visible: true)
        }

        private mutating func hide() {
            self = Item(key, label: label, visible: false)
        }

    }

    struct Menu {

        var items: [Item]
        var selected: Item?

        init (_ items: [Item]) {
            self.items = items
            selected = nil
        }

        func keys() -> [String] {
            return Array(map(items) { $0.key })
        }

        func index(key: String) -> Int? {
            for (index, item) in enumerate(items) {
                if item.key == key { return index }
            }
            return nil
        }

        mutating func select(key: String) {
            selected = items[index(key)!]
        }

        mutating func show(key: String) {
            items[index(key)!].show()
        }

        mutating func hide(key: String) {
            items[index(key)!].hide()
        }

    }

}