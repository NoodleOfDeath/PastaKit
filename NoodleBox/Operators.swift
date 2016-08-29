//
//  CustomOperations.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 4/11/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import Foundation

/// Append path component `rhs` to `lhs`
infix operator +/ { associativity left precedence 150 }
/// Append path extension `rhs` to `lhs`
infix operator +* { associativity left precedence 150 }

/// Modular division the way it was meant to be
infix operator %% { associativity left precedence 150 }

/// Assign value to `lhs` iff `rhs` is not `nil`
infix operator =? { associativity right precedence 90 assignment }
/// Assign value to `lhs` iff `rhs < lhs`
infix operator =< { associativity right precedence 90 assignment }
/// Assign value to `lhs` iff `rhs > lhs`
infix operator => { associativity right precedence 90 assignment }

/// Bridge between Swift <-> Objective-C
postfix operator * {}