//
//  Config.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/17/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

import Cocoa

class Config {

    let dataURL: NSURL = {
        let appName = NSBundle.mainBundle().infoDictionary!["CFBundleName"] as! String
        let basePath = NSSearchPathForDirectoriesInDomains(.ApplicationSupportDirectory, .UserDomainMask, true).first as! String
        let baseURL = NSURL(string: basePath.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)!
        let dataURL = baseURL.URLByAppendingPathComponent(appName)

        // TODO: Fail gracefully. Fall back to another directory on error.
        NSLog("[Config] Data path: \(dataURL.path!)")
        NSFileManager.defaultManager().createDirectoryAtPath(
            dataURL.path!,
            withIntermediateDirectories: true,
            attributes: nil,
            error: nil
        )
        return dataURL
    }()

}
