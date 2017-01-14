//
// Thread.swift
// NoodleBox
//
// Created by Thom Morgan on 10/15/16.
// Copyright © 2016 NoodleNation. All rights reserved.
//

import Foundation

/// 
public func delay(_ delay: Double, _ queue: DispatchQueue = DispatchQueue.main, _ closure: @escaping (() -> ())) {
    queue.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}

/// 
public func QueueInMain(_ block: @escaping () -> Void) {
    QueueInMain(.normal, block)
}

/// 
public func QueueInMain(_ queuePriority: Operation.QueuePriority, _ block: @escaping () -> Void) {
    let block = BlockOperation(block: block)
    block.queuePriority = queuePriority
    OperationQueue.main.addOperation(block)
}


