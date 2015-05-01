//
//  Int.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 5/1/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

extension Int {

    static func random(max: Int) -> Int {
        return Int.random(0, max)
    }

    static func random(min: Int, _ max: Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }

}