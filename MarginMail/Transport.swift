//
//  Transport.swift
//  MarginMail
//
//  Created by Stefano J. Attardi on 4/17/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

enum TransportType: String {
    case IMAP = "imap"
}

class Transport {

    var type: TransportType
    var hostname: String
    var port: Int

    var username: String?
    var password: String?

    init(type: TransportType, hostname: String, port: Int, username: String? = nil, password: String? = nil) {
        self.type = type
        self.hostname = hostname
        self.port = port
        self.username = username
        self.password = password
    }

    func createReader() -> MailReader? {
        switch self.type {
        case .IMAP:
            return IMAPReader(
                hostname: self.hostname,
                port: self.port,
                username: self.username,
                password: self.password
            )
        default:
            return nil
        }
    }

    func createWriter() -> MailWriter? {
        return nil
    }
    
}
