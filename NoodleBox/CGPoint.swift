//
//  CGPoint.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 6/23/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import CoreGraphics

// MARK: - ** Convenicence CGPoint Construction from 2-tuple **

public postfix func * (argument: (x: Int, y: Int)) -> CGPoint {
    return CGPointMake(CGFloat(argument.x), CGFloat(argument.y))
}

// MARK: - ** Public Operations **

// MARK: - Additive Operations

public func - (lhs: (x: CGFloat, y: CGFloat), rhs: (x: CGFloat, y: CGFloat)) -> CGPoint {
    return CGPointMake(lhs.x - rhs.x, lhs.y - rhs.y)
}

public func + (lhs: (x: CGFloat, y: CGFloat), x: CGFloat) -> CGPoint {
    return CGPointMake(lhs.x + x, lhs.y)
}

public func - (lhs: (x: CGFloat, y: CGFloat), x: CGFloat) -> CGPoint {
    return CGPointMake(lhs.x - x, lhs.y)
}

public func + (lhs: CGPoint, rhs: (x: CGFloat, y: CGFloat)) -> CGPoint {
    return CGPointMake(lhs.x + rhs.x, lhs.y + rhs.y)
}

public func - (lhs: CGPoint, rhs: (x: CGFloat, y: CGFloat)) -> CGPoint {
    return CGPointMake(lhs.x - rhs.x, lhs.y - rhs.y)
}

public func + (lhs: (x: CGFloat, y: CGFloat), rhs: CGPoint) -> CGPoint {
    return CGPointMake(lhs.x + rhs.x, lhs.y + rhs.y)
}

public func - (lhs: (x: CGFloat, y: CGFloat), rhs: CGPoint) -> CGPoint {
    return CGPointMake(lhs.x - rhs.x, lhs.y - rhs.y)
}

public func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPointMake(lhs.x + rhs.x, lhs.y + rhs.y)
}

public func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPointMake(lhs.x - rhs.x, lhs.y - rhs.y)
}

public func + (lhs: CGPoint, x: CGFloat) -> CGPoint {
    return CGPointMake(lhs.x + x, lhs.y)
}

public func - (lhs: CGPoint, x: CGFloat) -> CGPoint {
    return CGPointMake(lhs.x - x, lhs.y)
}

// MARK: - ** Additive Assignment Operations **

public func += (inout lhs: CGPoint, rhs: CGPoint) {
    lhs = lhs + rhs
}

public func -= (inout lhs: CGPoint, rhs: CGPoint) {
    lhs = lhs - rhs
}

extension CGPoint : Hashable {}

extension CGPoint {
    
    public var hashValue: Int {
        return "(x: \(x), y: \(y))".hashValue
    }
    
    public var transposed: CGPoint {
        return CGPointMake(y, x)
    }
    
}
