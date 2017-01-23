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
    return CGPoint(x: CGFloat(argument.x), y: CGFloat(argument.y))
}

// MARK: - ** Public Operations **

// MARK: - Additive Operations

public func - (lhs: (x: CGFloat, y: CGFloat), rhs: (x: CGFloat, y: CGFloat)) -> CGPoint {
    return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

public func + (lhs: (x: CGFloat, y: CGFloat), x: CGFloat) -> CGPoint {
    return CGPoint(x: lhs.x + x, y: lhs.y)
}

public func - (lhs: (x: CGFloat, y: CGFloat), x: CGFloat) -> CGPoint {
    return CGPoint(x: lhs.x - x, y: lhs.y)
}

public func + (lhs: CGPoint, rhs: (x: CGFloat, y: CGFloat)) -> CGPoint {
    return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

public func - (lhs: CGPoint, rhs: (x: CGFloat, y: CGFloat)) -> CGPoint {
    return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

public func + (lhs: (x: CGFloat, y: CGFloat), rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

public func - (lhs: (x: CGFloat, y: CGFloat), rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

public func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

public func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

public func + (lhs: CGPoint, x: CGFloat) -> CGPoint {
    return CGPoint(x: lhs.x + x, y: lhs.y)
}

public func - (lhs: CGPoint, x: CGFloat) -> CGPoint {
    return CGPoint(x: lhs.x - x, y: lhs.y)
}

// MARK: - ** Additive Assignment Operations **

public func += (lhs: inout CGPoint, rhs: CGPoint) {
    lhs = lhs + rhs
}

public func -= (lhs: inout CGPoint, rhs: CGPoint) {
    lhs = lhs - rhs
}

extension CGPoint : Hashable {}

extension CGPoint {
    
    public var hashValue: Int {
        return "(x: \(x), y: \(y))".hashValue
    }
    
    public var transposed: CGPoint {
        return CGPoint(x: y, y: x)
    }
    
}
