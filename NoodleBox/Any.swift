//
// Any.swift
// NoodleBox
//
// Created by NoodleOfDeath on 4/8/16.
// Copyright © 2016 NoodleNation. All rights reserved.
//

import Foundation

// MARK: -

/// Optionally assigns `rhs` to `lhs`, iff `rhs != nil`.
/// - parameter lhs: assignment target.
/// - parameter rhs: value to assign to `lhs`.
public func =? <T>(lhs: inout T?, rhs: T?) {
    lhs! =? rhs
}

/// Optionally assigns `rhs` to `lhs`, iff `rhs != nil`.
/// - parameter lhs: assignment target.
/// - parameter rhs: value to assign to `lhs`.
public func =? <T>(lhs: inout T!, rhs: T?) {
    guard let rhs = rhs else { return }
    lhs = rhs
}

/// Optionally assigns `rhs` to `lhs`, iff `rhs != nil`.
/// - parameter lhs: assignment target.
/// - parameter rhs: value to assign to `lhs`.
public func =? <T>(lhs: inout T, rhs: T?) {
    guard let rhs = rhs else { return }
    lhs = rhs
}
