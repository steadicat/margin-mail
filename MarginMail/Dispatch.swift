//
//  Dispatch.swift
//  MarginMail
//
//  Created by Artem Nezvigin on 4/20/15.
//  Copyright (c) 2015 Margin Labs. All rights reserved.
//

class Dispatch {

    enum Priority {
        case HIGH
        case BACKGROUND
    }

    static func after(seconds: Double, block: () -> Void) {
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(seconds * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue(), block)
    }

    static func main(block: () -> Void) {
        dispatch_async(dispatch_get_main_queue()) {
            block()
        }
    }

    static func queue(priority: Priority, block: () -> Void) {
        let queue: Int
        switch (priority) {
        case .HIGH:
            queue = DISPATCH_QUEUE_PRIORITY_HIGH
        default:
            queue = DISPATCH_QUEUE_PRIORITY_BACKGROUND
        }
        dispatch_async(dispatch_get_global_queue(queue, 0)) {
            block()
        }
    }

}