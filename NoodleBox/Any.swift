//
//  AnyObject.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 4/8/16.
//  Copyright © 2016 NoodleOfDeath. All rights reserved.
//

import UIKit
import Foundation

// MARK: -

public func =? <T>(inout lhs: T?, rhs: T?) {
    if let rhs = rhs {
        lhs = rhs
    }
}

public func =? <T>(inout lhs: T!, rhs: T?) {
    if let rhs = rhs {
        lhs = rhs
    }
}

public func =? <T>(inout lhs: T, rhs: T?) {
    if let rhs = rhs {
        lhs = rhs
    }
}

public func delay(delay: Double, _ queue: dispatch_queue_t = dispatch_get_main_queue(), _ closure: (() -> ())) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        queue, closure)
}

public func QueueInMain(block: () -> Void) {
    QueueInMain(.Normal, block)
}

public func QueueInMain(queuePriority: NSOperationQueuePriority, _ block: () -> Void) {
    let block = NSBlockOperation(block: block)
    block.queuePriority = queuePriority
    NSOperationQueue.mainQueue().addOperation(block)
}


