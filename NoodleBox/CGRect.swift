//
//  CGRect.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 4/5/16.
//  Copyright © 2016 NoodleOfDeath. All rights reserved.
//

// MARK: - ** Import Modules **

import CoreGraphics

// MARK: - ** Convenience Operations **

// MARK: - Additive Operations

/**
 Sums two `CGRect` public structures.
 - parameter augend: The augend for this sum operation
 - parameter addend: The addend for this sum operation
 - returns: The Sums `augend` and `addend` where `x`, `y`, `width`, and 
 `height` are the Sums the respective two properties from `augend` and
 `addend`.
 */
public func + (augend: CGRect, addend: CGRect) -> CGRect {
    return CGRectMake(augend.x + addend.x, 
                      augend.y + addend.y, 
                      augend.width + addend.width, 
                      augend.height + addend.height)
}

/**
 Sums a `CGRect` public structure and a `CGPoint` public structure.
 - parameter augend: The augend for this sum operation.
 - parameter addend: The addend for this sum operation.
 - returns: The Sums `augend` and `addend` where only the `x` and `y` of
 each vector are summed, preserving the `width` and `height` of `augend` in
 the return `CGRect`.
 */
public func + (augend: CGRect, addend: CGPoint) -> CGRect {
    return CGRectMake(augend.x + addend.x, 
                      augend.y + addend.y, 
                      augend.width, augend.height)
}

/**
 Sums a `CGRect` public structure and a `CGSize` public structure.
 - parameter augend: The augend for this sum operation.
 - parameter addend: The addend for this sum operation.
 - returns: The Sums `augend` and `addend` where only the `width` and `height`
 of each vector are summed, preserving the `x` and `y` of `augend` in
 the return `CGRect`.
 */
public func + (augend: CGRect, addend: CGSize) -> CGRect {
    return CGRectMake(augend.x, augend.y, 
                      augend.width + addend.width, 
                      augend.height + addend.height)
}

/**
 Sums a `CGRect` public structure and a `CGFloat` 1-tuple.
 - parameter augend: The augend for this sum operation.
 - parameter addend: The 1-tuple addend for this sum operation.
 - returns: The Sums `augend` and `addend` where only `x` is affected, being
 the Sums `augend.x` and `addend`. The rest of the vector properties from
 `augend` are preserved in the return `CGRect`.
 */
public func + (augend: CGRect, addend: (CGFloat)) -> CGRect {
    return CGRectMake(augend.x + addend,
                      augend.y, augend.width, augend.height)
}

/**
 Sums a `CGRect` and a `(CGFloat, CGFloat)` 2-tuple.
 - parameter augend: The augend for this sum operation.
 - parameter addend: The 2-tuple addend for this sum operation.
 - returns: The Sums `augend` and `addend` where only `x` and `y` are summed
 with their ordinally respective vector property of the `addend` tuple. 
 The rest of the vector properties from `augend` are preserved in the return
 `CGRect`.
 */
public func + (augend: CGRect, addend: (CGFloat, CGFloat)) -> CGRect {
    return CGRectMake(augend.x + addend.0, 
                      augend.y + addend.1, 
                      augend.width, augend.height)
}

/**
 Sums a `CGRect` and a `(CGFloat, CGFloat, CGFloat)` 3-tuple.
 - parameter augend: The augend for this sum operation.
 - parameter addend: The 3-tuple addend for this sum operation.
 - returns: The Sums `augend` and `addend` where only `x`, `y`, and `width` 
 are summed with their ordinally respective vector property of the `addend` 
 tuple.  The rest of the vector properties from `augend` are preserved in 
 the return `CGRect`.
 */
public func + (augend: CGRect, addend: (CGFloat, CGFloat, CGFloat)) -> CGRect {
    return CGRectMake(augend.x + addend.0, 
                      augend.y + addend.1, 
                      augend.width + addend.2, 
                      augend.height)
}

/**
 Sums a `CGRect` and a `(CGFloat, CGFloat, CGFloat, CGFloat)` 
 4-tuple.
 - parameter augend: The augend for this sum operation.
 - parameter addend: The 4-tuple addend for this sum operation.
 - returns: The Sums `augend` and `addend` where each vector property of 
 `augend` is summed with its ordinally respective vector property of the
 `addend` tuple. The rest of the vector properties from `augend` are preserved 
 in the return `CGRect`.
 */
public func + (augend: CGRect, addend: (CGFloat, CGFloat, CGFloat, CGFloat)) -> CGRect {
    return CGRectMake(augend.x + addend.0, 
                      augend.y + addend.1, 
                      augend.width + addend.2, 
                      augend.height + addend.3)
}

// MARK: - Additive Assignment Operations

/**
 Sums two `CGRect` public structures and assigns the result to the `augend`.
 - parameter augend: The augend for this sum operation and assignment target.
 - parameter addend: The addend for this sum operation.
 - returns: The Sums `augend` and `addend` where `x`, `y`, `width`, and 
 `height` are the Sums the respective two properties from `augend` and
 `addend`.
 */
public func += (inout augend: CGRect, addend: CGRect) {
    augend = augend + addend
}

/**
 Sums a `CGRect` public structure and a `CGPoint` public structure and assigns the result to 
 the `augend`.
 - parameter augend: The augend for this sum operation and assignment target.
 - parameter addend: The addend for this sum operation.
 - returns: The Sums `augend` and `addend` where only the `x` and `y` of
 each vector are summed, preserving the `width` and `height` of `augend` in
 the return `CGRect`.
 */
public func += (inout augend: CGRect, addend: CGPoint) {
    augend = augend + addend
}

/**
 Sums a `CGRect` public structure and a `CGSize` public structure and assigns the result to 
 the `augend`.
 - parameter augend: The augend for this sum operation and assignment target.
 - parameter addend: The addend for this sum operation.
 - returns: The Sums `augend` and `addend` where only the `width` and `height`
 of each vector are summed, preserving the `x` and `y` of `augend` in
 the return `CGRect`.
 */
public func += (inout augend: CGRect, addend: CGSize) {
    augend = augend + addend
}

/**
 Sums a `CGRect` public structure and a `CGFloat` 1-tuple and assigns the result to 
 the `augend`.
 - parameter augend: The augend for this sum operation and assignment target.
 - parameter addend: The 1-tuple addend for this sum operation.
 - returns: The Sums `augend` and `addend` where only `x` is affected, being
 the Sums `augend.x` and `addend`. The rest of the vector properties from
 `augend` are preserved in the return `CGRect`.
 */
public func += (inout augend: CGRect, addend: CGFloat) {
    augend = augend + addend
}

/**
 Sums a `CGRect` and a `(CGFloat, CGFloat)` 2-tuple assigns the result to 
 the `augend`.
 - parameter augend: The augend for this sum operation and assignment target.
 - parameter addend: The 2-tuple addend for this sum operation.
 - returns: The Sums `augend` and `addend` where only `x` and `y` are summed
 with their ordinally respective vector property of the `addend` tuple. 
 The rest of the vector properties from `augend` are preserved in the return
 `CGRect`.
 */
public func += (inout augend: CGRect, addend: (CGFloat, CGFloat)) {
    augend = augend + addend
}

/**
 Sums a `CGRect` and a `(CGFloat, CGFloat, CGFloat)` 3-tuple assigns the result
 to the `augend`.
 - parameter augend: The augend for this sum operation and assignment target.
 - parameter addend: The 3-tuple addend for this sum operation.
 - returns: The Sums `augend` and `addend` where only `x`, `y`, and `width` 
 are summed with their ordinally respective vector property of the `addend` 
 tuple.  The rest of the vector properties from `augend` are preserved in 
 the return `CGRect`.
 */
public func += (inout augend: CGRect, addend: (CGFloat, CGFloat, CGFloat)) {
    augend = augend + addend
}

/**
 Sums a `CGRect` and a `(CGFloat, CGFloat, CGFloat, CGFloat)` 
 4-tuple assigns the result to the `augend`.
 - parameter augend: The augend for this sum operation and assignment target.
 - parameter addend: The 4-tuple addend for this sum operation.
 - returns: The Sums `augend` and `addend` where each vector property of 
 `augend` is summed with its ordinally respective vector property of the
 `addend` tuple. The rest of the vector properties from `augend` are preserved 
 in the return `CGRect`.
 */
public func += (inout augend: CGRect, addend: (CGFloat, CGFloat, CGFloat, CGFloat)) {
    augend = augend + addend
}

// MARK: - ** CGRect - Extension (Convenient Dimensions) **

extension CGRect {
    
    // MARK: - ** Public Properties **
    
    // MARK: - Composite

    /**
     The `x` value of this `CGRect`'s `origin`.
     */
    public var x: CGFloat {
        get { return origin.x }
        set { origin.x = newValue }
    }

    /**
     The `y` value of this `CGRect`'s `origin`.
     */
    public var y: CGFloat {
        get { return origin.y }
        set { origin.y = newValue}
    }
    
    public var center: CGPoint {
        get { return CGPointMake(x + width / 2, y + height / 2) }
        set { (x, y) = (newValue.x - width / 2, newValue.y - height / 2) }
    }
    
    // MARK: - Computed Get-Only Properties

    /**
     A 2-tuple containing this `CGRect`'s `maxX` and `maxY` values,
     respectively.
     */
    public var maxXY: CGPoint {
        return CGPointMake(maxX, maxY)
    }

}

extension CGRect : Hashable {}

extension CGRect {
    
    public var hashValue: Int {
        return "(x: \(x), y: \(y), width: \(width), height: \(height))".hashValue
    }
    
}


