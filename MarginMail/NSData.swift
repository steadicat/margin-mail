//
//  NSData.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/17/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import SQLite

extension NSData: SQLite.Value {

    public class var declaredDatatype: String {
        return Blob.declaredDatatype
    }

    public class func fromDatatypeValue(blobValue: Blob) -> Self {
        return self(bytes: blobValue.bytes, length: blobValue.length)
    }

    public var datatypeValue: Blob {
        return Blob(bytes: bytes, length: length)
    }
    
}
