//
//  CustomOperations.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 4/11/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import Foundation

/// Append path component `rhs` to `lhs`
infix operator +/ : AdditionPrecedence
/// Append path extension `rhs` to `lhs`
infix operator +* : AdditionPrecedence

/// Modular division the way it was meant to be
infix operator %% : AdditionPrecedence

/// Assign value to `lhs` iff `rhs` is not `nil`
infix operator =? : AssignmentPrecedence
/// Assign value to `lhs` iff `rhs < lhs`
infix operator =< : AssignmentPrecedence
/// Assign value to `lhs` iff `rhs > lhs`
infix operator => : AssignmentPrecedence

/// Bridge between Swift <-> Objective-C
postfix operator *


