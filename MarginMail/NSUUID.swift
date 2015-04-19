//
//  NSUUID.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/17/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Foundation
import SQLite

extension NSUUID: SQLite.Value {

    public class var declaredDatatype: String {
        return String.declaredDatatype
    }

    public class func fromDatatypeValue(datatypeValue: String) -> NSUUID {
        return NSUUID(UUIDString: datatypeValue)!
    }

    public var datatypeValue: String {
        return UUIDString
    }
    
}