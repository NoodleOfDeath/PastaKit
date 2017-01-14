//
// Any.swift
// NoodleBox
//
// Created by NoodleOfDeath on 4/8/16.
// Copyright © 2016 NoodleNation. All rights reserved.
//

import UIKit
import Foundation

// MARK: -

/// 
public func =? <T>(lhs: inout T?, rhs: T?) {
    if let rhs = rhs {
        lhs = rhs
    }
}

/// 
public func =? <T>(lhs: inout T!, rhs: T?) {
    if let rhs = rhs {
        lhs = rhs
    }
}

/// 
public func =? <T>(lhs: inout T, rhs: T?) {
    if let rhs = rhs {
        lhs = rhs
    }
}
