//
//  Any.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 4/8/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import UIKit
import Foundation

// MARK: -

public func =? <T>(lhs: inout T?, rhs: T?) {
    if let rhs = rhs {
        lhs = rhs
    }
}

public func =? <T>(lhs: inout T!, rhs: T?) {
    if let rhs = rhs {
        lhs = rhs
    }
}

public func =? <T>(lhs: inout T, rhs: T?) {
    if let rhs = rhs {
        lhs = rhs
    }
}

public func delay(_ delay: Double, _ queue: DispatchQueue = DispatchQueue.main, _ closure: @escaping (() -> ())) {
    queue.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}

public func QueueInMain(_ block: @escaping () -> Void) {
    QueueInMain(.normal, block)
}

public func QueueInMain(_ queuePriority: Operation.QueuePriority, _ block: @escaping () -> Void) {
    let block = BlockOperation(block: block)
    block.queuePriority = queuePriority
    OperationQueue.main.addOperation(block)
}


