//
//  CGSize.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 6/6/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import CoreGraphics

public func + (lhs: CGSize, rhs: CGSize) -> CGSize {
    return CGSizeMake(lhs.width + rhs.width, lhs.height + rhs.height)
}

public func - (lhs: CGSize, rhs: CGSize) -> CGSize {
    return CGSizeMake(lhs.width - rhs.width, lhs.height - rhs.height)
}

public func += (inout lhs: CGSize, rhs: CGSize) {
    lhs = lhs + rhs
}

public func -= (inout lhs: CGSize, rhs: CGSize) {
    lhs = lhs - rhs
}

extension CGSize : Hashable {}

extension CGSize {
    
    public var hashValue: Int {
        return "(width: \(width), height: \(height))".hashValue
    }
    
}

extension CGSize {
    
    public func transpose() -> CGSize {
        return CGSizeMake(height, width)
    }
    
}