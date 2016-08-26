//
//  CustomOperations.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 4/11/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import Foundation

infix operator +/ { associativity left precedence 150 }
infix operator +* { associativity left precedence 150 }

infix operator %% { associativity left precedence 150 }

/// Assign value to `lhs` iff `rhs` is not `nil`
infix operator =? { associativity right precedence 90 assignment }

infix operator =< { associativity right precedence 90 assignment }
infix operator => { associativity right precedence 90 assignment }

postfix operator ~ {}