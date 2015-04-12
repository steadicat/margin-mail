//
//  Array.swift
//  Margin Mail
//
//  Created by Artem Nezvigin on 4/12/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

extension Array {

    func each(callback: (T) -> ()) {
        for object: T in self {
            callback(object)
        }
    }

}