//
//  NSRange.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 4/12/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import Foundation

// MARK: - ** Convenience `NSRange` Operations **

// MARK: - Equatable Protocol Conformance

extension NSRange : Equatable {}
extension NSRange : Comparable {}

/// Compares if two `NSRange` objects have equal location and length
/// - parameter lhs: A reference range
/// - parameter rhs: A range to compare against the reference range
/// - returns: `true` if the two ranges are identical; otherwise `false`
public func == (lhs: NSRange, rhs: NSRange) -> Bool {
    return NSEqualRanges(lhs, rhs)
}

/// Compares if two `NSRange` objects are not equivalent in location and length
/// - parameter lhs: A reference range
/// - parameter rhs: A range to compare against the reference range
/// - returns: `true` if the two ranges are identical; otherwise `false`
public func != (lhs: NSRange, rhs: NSRange) -> Bool {
    return !NSEqualRanges(lhs, rhs)
}

// MARK: - Comparison Operations

/// Compares if one `NSRange` is strictly less than another range.
/// - parameter lhs: A reference range
/// - parameter rhs: A range to compare against the reference range
/// - returns: `true` if `lhs.maxRange < rhs.location`; `false` if otherwise
public func < (lhs: NSRange, rhs: NSRange) -> Bool {
    return lhs.maxRange < rhs.location
}

/// Compares if one `NSRange` is strictly greater than another range.
/// - parameter lhs: A reference range
/// - parameter rhs: A range to compare against the reference range
/// - returns: `true` if `lhs.location > rhs.maxRange`; `false` if otherwise
public func > (lhs: NSRange, rhs: NSRange) -> Bool {
    return lhs.location > rhs.maxRange
}

// MARK: - Additional Comparison Operations

///  Compares if a range is strictly less than than a location.
/// - parameter lhs: A reference range.
/// - parameter rhs: A range to compare against the reference range.
/// - returns: `true` if `lhs.maxRange < rhs`; `false` if otherwise.
public func < (lhs: NSRange, rhs: Int) -> Bool {
    return lhs.maxRange < rhs
}

///  Compares if a range is strictly greater than a location.
/// - parameter lhs: A reference range.
/// - parameter rhs: A location to compare against the reference range.
/// - returns: `true` if `lhs.location > rhs`; `false` if otherwise.
public func > (lhs: NSRange, rhs: Int) -> Bool {
    return lhs.location > rhs
}

///  Compares if a location is strictly less than than a range.
/// - parameter lhs: A reference location.
/// - parameter rhs: A range to compare against the reference location.
/// - returns: `true` if `lhs < rhs.location`; `false` if otherwise.
public func < (lhs: Int, rhs: NSRange) -> Bool {
    return lhs < rhs.location
}

///  Compares if a location is strictly greater than a range.
/// - parameter lhs: A reference location.
/// - parameter rhs: A range to compare against the reference location.
/// - returns: `true` if `lhs > rhs.maxRange`; `false` if otherwise.
public func > (lhs: Int, rhs: NSRange) -> Bool {
    return lhs > rhs.maxRange
}

// MARK: - Addition Operations

///  Adds an integer to the location of a range.
/// - parameter lhs: A range to shift.
/// - parameter rhs: Distance to shift the range location.
/// - returns: A range whose `location = lhs.location + rhs`.
public func + (lhs: NSRange, rhs: Int) -> NSRange {
    return NSMakeRange(lhs.location + rhs, lhs.length)
}

///  Adds two `NSRange` objects like matricies.
/// - parameter lhs: The augend range.
/// - parameter rhs: The addend range.
/// - returns: A range whose `location = lhs.location + rhs.location` and whose
 /// `length = lhs.length + rhs.length`.
public func + (lhs: NSRange, rhs: NSRange) -> NSRange {
    return NSMakeRange(lhs.location + rhs.location, lhs.length + rhs.length)
}

///  Adds an integer tuple to the location and length of a range.
/// - parameter lhs: A range to shift.
/// - parameter rhs: Distance to shift the range location and length as a second
 /// order integer tuple.
/// - returns: A range whose `location = lhs.location + rhs.0` and whose
 /// `length = lhs.length + rhs.1`.
public func + (lhs: NSRange, rhs: (location: Int, length: Int)) -> NSRange {
    return NSMakeRange(lhs.location + rhs.location, lhs.length + lhs.length)
}

// MARK: - Addition Assignment Operations

///  Adds an integer to the location of a range and assigns the sum to
 /// the augend.
/// - parameter lhs: A range to shift and assignment target.
/// - parameter rhs: Distance to shift the range location.
public func += (lhs: inout NSRange, rhs: Int) {
    lhs = NSMakeRange(lhs.location + rhs, lhs.length)
}

///  Adds two `NSRange` objects like matricies and assigns the sum to the augend.
/// - parameter lhs: The augend range and assignment target.
/// - parameter rhs: The addend range.
public func += (lhs: inout NSRange, rhs: NSRange) {
    lhs = NSMakeRange(lhs.location + rhs.location, lhs.length + rhs.length)
}

///  Adds an integer tuple to the location and length of a range and assigns the
 /// result to the augend.
/// - parameter lhs: A range to shift and assignment target.
/// - parameter rhs: Distance to shift the range location and length as a second
 /// order integer tuple.
public func += (lhs: inout NSRange, rhs: (location: Int, length: Int)) {
    lhs = NSMakeRange(lhs.location + rhs.location, lhs.length + lhs.length)
}

/** A range with `location = 0` and `length = 0` */
public let NSRangeZero = NSMakeRange(0, 0)

/** A range with `location = NSNotFound` and `length = NSNotFound` */
public let NSRangeNotFound = NSMakeRange(NSNotFound, NSNotFound)

extension NSRange {

    public var maxRange: Int {
        return NSMaxRange(self)
    }
    
    public func contains(_ range: NSRange) -> Bool {
        return union(range) == self
    }

    public func contains(_ loc: Int) -> Bool {
        return NSLocationInRange(loc, self)
    }
    
    public func doesNotContain(_ range: NSRange) -> Bool {
        return union(range) != self
    }
    
    public func doesNotContain(_ loc: Int) -> Bool {
        return !NSLocationInRange(loc, self)
    }
    
    public func union(_ range: NSRange) -> NSRange {
        return NSUnionRange(self, range)
    }
    
    public func intersection(_ range: NSRange) -> NSRange {
        return NSIntersectionRange(self, range)
    }

}


