//
//  Env.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/17/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class Env {

    static let appName: String = {
        return NSBundle.mainBundle().infoDictionary!["CFBundleName"] as! String
    }()

    static let dataURL: NSURL = {
        let basePath = NSSearchPathForDirectoriesInDomains(.ApplicationSupportDirectory, .UserDomainMask, true).first as! String
        let dataPath = basePath.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        let dataURL = NSURL(string: dataPath)!.URLByAppendingPathComponent(appName)

        NSLog("[Env] Data URL: \(dataURL.path!)")
        NSFileManager.defaultManager().createDirectoryAtPath(
            dataURL.path!,
            withIntermediateDirectories: true,
            attributes: nil,
            error: nil
        )
        return dataURL
    }()

    static let dataPath: String = {
        return dataURL.path!
    }()

    static func dataURLForName(name: String) -> NSURL {
        return Env.dataURL.URLByAppendingPathComponent(name)
    }

    static func dataPathForName(name: String) -> String {
        return dataURLForName(name).path!
    }

}
