//
//  UInt256.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 7/10/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import Foundation

// Bit Shifting only supports lhs = 1

@warn_unused_result
public func << (lhs: UInt256, rhs: UInt256) -> UInt256 {
    if lhs > 1 { print("Warning: Only supports binary bitshifts (i.e. 1 << n, where n < 256. Shifting any other numbers than 1 may result in unexpected behavior.") }
    if rhs > 255 { fatalError("shift amount is larger than type size in bits") }
    let shift = UInt64(rhs.parts[7]) % 32
    let offset = Int(rhs.parts[7] / 32)
    var parts = [UInt32]()
    for i in (0 ..< 8) {
        let part: UInt64 = (i + offset < 8 ? UInt64(lhs.parts[i + offset]) : 0)
        let sum32 = UInt32(part << shift)
        parts.append(sum32)
    }
    return UInt256(parts)
}

@warn_unused_result
public func >> (lhs: UInt256, rhs: UInt256) -> UInt256 {
    if lhs > 1 { print("Warning: Only supports binary bitshifts (i.e. 1 << n, where n < 256. Shifting any other numbers than 1 may result in unexpected behavior.") }
    if rhs > 255 { fatalError("shift amount is larger than type size in bits") }
    let shift = UInt64(rhs.parts[7]) % 32
    let offset = Int(rhs.parts[7] / 32)
    var parts = [UInt32]()
    for i in (0 ..< 8) {
        let part: UInt64 = (i - offset > 0 ? UInt64(lhs.parts[i - offset]) : 0)
        let sum32 = UInt32(part >> shift)
        parts.append(sum32)
    }
    return UInt256(parts)
}

@warn_unused_result
public func == (lhs: UInt256, rhs: UInt256) -> Bool {
    return lhs.parts == rhs.parts
}

@warn_unused_result
public func < (lhs: UInt256, rhs: UInt256) -> Bool {
    for i in 0 ..< 8 {
        guard lhs.parts[i] < rhs.parts[i] else { continue }
        return true
    }
    return false
}

@warn_unused_result
public func > (lhs: UInt256, rhs: UInt256) -> Bool {
    for i in 0 ..< 8 {
        guard lhs.parts[i] > rhs.parts[i]  else { continue }
        return true
    }
    return false
}

@warn_unused_result
public func <= (lhs: UInt256, rhs: UInt256) -> Bool {
    return lhs < rhs || lhs == rhs
}

@warn_unused_result
public func >= (lhs: UInt256, rhs: UInt256) -> Bool {
    return lhs > rhs || lhs == rhs
}

/// Adds `lhs` and `rhs`, returning the result and trapping in case of
/// arithmetic overflow (except in -Ounchecked builds).
@warn_unused_result
public func + (lhs: UInt256, rhs: UInt256) -> UInt256 {
    var parts = [UInt32]()
    var carry = false
    for i in (0 ..< 8).reverse() {
        let lpart = UInt64(lhs.parts[i])
        let rpart = UInt64(rhs.parts[i])
        let comp = lpart == UInt64(UInt32.max) && rpart == UInt64(UInt32.max)
        let sum64 = lpart + rpart + (carry || comp ? 1 : 0)
        let sum32 = UInt32((sum64 << 32) >> 32)
        carry = sum64 > UInt64(UInt32.max)
        parts.insert(sum32, atIndex: 0)
    }
    return UInt256(parts)
}

/// Adds `lhs` and `rhs`, returning the result and trapping in case of
/// arithmetic overflow (except in -Ounchecked builds).
public func += (inout lhs: UInt256, rhs: UInt256) {
    lhs = lhs + rhs
}

/// Subtracts `lhs` and `rhs`, returning the result and trapping in case of
/// arithmetic overflow (except in -Ounchecked builds).
@warn_unused_result
public func - (lhs: UInt256, rhs: UInt256) -> UInt256 {
    var parts = [UInt32]()
    var borrow = false
    var gave = false
    for i in (0 ..< 8).reverse() {
        borrow = lhs.parts[i] < rhs.parts[i]
        let lpart = UInt64(lhs.parts[i]) - (gave ? 1 : 0) + (borrow ? UInt64(UInt32.max) : 0)
        let rpart = UInt64(rhs.parts[i])
        let sum64 = lpart - rpart
        let sum32 = UInt32((sum64 << 32) >> 32)
        gave = borrow
        parts.insert(sum32, atIndex: 0)
    }
    return UInt256(parts)
}

public func -= (inout lhs: UInt256, rhs: UInt256) {
    lhs = lhs - rhs
}

/// Multiplies `lhs` and `rhs`, returning the result and trapping in case of
/// arithmetic overflow (except in -Ounchecked builds).
/// - Complexity:  O(64)
@warn_unused_result
public func * (lhs: UInt256, rhs: UInt256) -> UInt256 {
    // TODO: -Not Implemented
    return UInt256()
}

public func *= (inout lhs: UInt256, rhs: UInt256) {
    lhs = lhs * rhs
}

/// Divides `lhs` and `rhs`, returning the result and trapping in case of
/// arithmetic overflow (except in -Ounchecked builds).
@warn_unused_result
public func / (lhs: UInt256, rhs: UInt256) -> UInt256 {
    // TODO: -Not Implemented
    return UInt256()
}

public func /= (inout lhs: UInt256, rhs: UInt256) {
    lhs = lhs / rhs
}

/// Divides `lhs` and `rhs`, returning the remainder and trapping in case of
/// arithmetic overflow (except in -Ounchecked builds).
@warn_unused_result
public func % (lhs: UInt256, rhs: UInt256) -> UInt256 {
    // TODO: -Not Implemented
    return UInt256()
}

public func %= (inout lhs: UInt256, rhs: UInt256) {
    lhs = lhs % rhs
}

extension UInt256 {
    
    @warn_unused_result
    public func toIntMax() -> IntMax {
        return Int64(parts[6] << 32) + Int64(parts[7])
    }
    
    @warn_unused_result
    public func toUIntMax() -> UIntMax {
        return UInt64(parts[6] << 32) + UInt64(parts[7])
    }
    
    /// Adds `lhs` and `rhs`, returning the result and a `Bool` that is
    /// `true` iff the operation caused an arithmetic overflow.
    public static func addWithOverflow(lhs: UInt256, _ rhs: UInt256) -> (UInt256, overflow: Bool) {
        var parts = [UInt32]()
        var carry = false
        for i in (0 ..< 8).reverse() {
            let lpart = UInt64(lhs.parts[i])
            let rpart = UInt64(rhs.parts[i])
            let comp = lpart == UInt64(UInt32.max) && rpart == UInt64(UInt32.max)
            let sum64 = lpart + rpart + (carry || comp ? 1 : 0)
            let sum32 = UInt32((sum64 << 32) >> 32)
            carry = sum64 > UInt64(UInt32.max)
            parts.insert(sum32, atIndex: 0)
        }
        return (UInt256(parts), parts[0] > 0x8fffffff)
    }
    
    /// Subtracts `lhs` and `rhs`, returning the result and a `Bool` that is
    /// `true` iff the operation caused an arithmetic overflow.
    public static func subtractWithOverflow(lhs: UInt256, _ rhs: UInt256) -> (UInt256, overflow: Bool) {
        // TODO: -
        var parts = [UInt32]()
        var borrow = false
        var gave = false
        for i in (0 ..< 8).reverse() {
            borrow = lhs.parts[i] < rhs.parts[i]
            let lpart = UInt64(lhs.parts[i]) - (gave ? 1 : 0) + (borrow ? UInt64(UInt32.max) : 0)
            let rpart = UInt64(rhs.parts[i])
            let sum64 = lpart - rpart
            let sum32 = UInt32((sum64 << 32) >> 32)
            gave = borrow
            parts.insert(sum32, atIndex: 0)
        }
        return (UInt256(parts), parts[0] > 0x8fffffff)
    }
    
    /// Multiplies `lhs` and `rhs`, returning the result and a `Bool` that is
    /// `true` iff the operation caused an arithmetic overflow.
    public static func multiplyWithOverflow(lhs: UInt256, _ rhs: UInt256) -> (UInt256, overflow: Bool) {
        // TODO: -Not Implemented
        return (UInt256(), false)
    }
    
    /// Divides `lhs` and `rhs`, returning the result and a `Bool` that is
    /// `true` iff the operation caused an arithmetic overflow.
    public static func divideWithOverflow(lhs: UInt256, _ rhs: UInt256) -> (UInt256, overflow: Bool) {
        // TODO: -Not Implemented
       return (UInt256(), false)
    }
    
    /// Divides `lhs` and `rhs`, returning the remainder and a `Bool` that is
    /// `true` iff the operation caused an arithmetic overflow.
    public static func remainderWithOverflow(lhs: UInt256, _ rhs: UInt256) -> (UInt256, overflow: Bool) {
        // TODO: -Not Implemented
        return (UInt256(), false)
    }
    
}

public struct UInt256 : UnsignedIntegerType, Comparable, Equatable {
    
    public typealias _ObjectiveCType = NSNumber
    public typealias IntegerLiteralType = UInt256
    public typealias Distance = Int32
    public typealias Stride = Int32
    
    private let parts: [UInt32]
    
    private var part0: UInt32 { return parts[0] }
    private var part1: UInt32 { return parts[1] }
    private var part2: UInt32 { return parts[2] }
    private var part3: UInt32 { return parts[3] }
    private var part4: UInt32 { return parts[4] }
    private var part5: UInt32 { return parts[5] }
    private var part6: UInt32 { return parts[6] }
    private var part7: UInt32 { return parts[7] }
    
    public static var max: UInt256 {
        return UInt256([.max, .max, .max, .max, .max, .max, .max, .max])
    }
    
    public var description: String {
        var hex = "0x"
        for i in 0 ..< parts.count {
            let part = parts[i]
            hex += String(format:"%08X", part)
            if i + 1 < parts.count {
                hex += ":"
            }
        }
        return "\(hex)"
    }
    
    public var componentDescription: String {
        return "\(parts)"
    }
    
    public var hashValue: Int {
        return (part0.hashValue + part1.hashValue + part2.hashValue + part3.hashValue + part4.hashValue + part5.hashValue + part6.hashValue + part7.hashValue).hashValue
    }
    
    public var data: NSData {
        let bytes = [part0, part1, part2, part3, part4, part5, part6, part7]
        return NSData(bytes: bytes, length: 32)
    }
    
    public init(_builtinIntegerLiteral builtinIntegerLiteral: _MaxBuiltinIntegerType) {
        self.init(UInt64(_builtinIntegerLiteral: builtinIntegerLiteral))
    }
    
    public init() { parts = [0, 0, 0, 0, 0, 0, 0, 0] }
    
    public init(_ newParts: [UInt32]) {
        var zeros = UInt256().parts
        zeros.replaceRange((8 - newParts.count ..< 8), with: newParts)
        parts = zeros
    }
    
    public init(_ v: Int8) {
        self.init(UInt64(v))
    }
    
    public init(_ v: UInt8) {
        self.init(UInt64(v))
    }
    
    public init(_ v: Int16) {
        self.init(UInt64(v))
    }
    
    public init(_ v: UInt16) {
        self.init(UInt64(v))
    }
    
    public init(_ v: Int32) {
        self.init(UInt64(v))
    }
    
    public init(_ v: UInt32) {
        self.init(UInt64(v))
    }
    
    public init(_ v: Int) {
        self.init(UInt64(v))
    }
    
    public init(_ v: UInt) {
        self.init(UInt64(v))
    }
    
    public init(_ v: Int64) {
        self.init(UInt64(v))
    }
    
    public init(_ v: UInt64) {
        self.init([UInt32(v >> 32), UInt32((v << 32) >> 32)])
    }
    
    public init(integerLiteral value: IntegerLiteralType) {
        parts = value.parts
    }
    
    public init?(data: NSData) {
        var parts = [UInt32]()
        let size = sizeof(UInt32)
        for i in 0 ..< 8 {
            var part = UInt32()
            data.getBytes(&part, range: NSMakeRange(i * size, size))
            parts.append(part)
        }
        guard parts.count == 8 else { return nil }
        self.init(parts)
    }
    
    @warn_unused_result
    public func advancedBy(n: Stride) -> UInt256 {
        return self + UInt256(n)
    }
    
    @warn_unused_result
    public func advancedBy(n: Distance, limit: UInt256) -> UInt256 {
        return limit - UInt256(n) > self ? self + UInt256(n) : limit
    }
    
    @warn_unused_result
    public func distanceTo(end: UInt256) -> Distance {
        return end - self
    }
    
    /// Returns the previous consecutive value in a discrete sequence.
    ///
    /// If `UInt256` has a well-defined successor,
    /// `UInt256.successor().predecessor() == UInt256`.  If `UInt256` has a
    /// well-defined predecessor, `UInt256.predecessor().successor() ==
    /// UInt256`.
    ///
    /// - Requires: `UInt256` has a well-defined predecessor.
    @warn_unused_result
    public func predecessor() -> UInt256 {
        return advancedBy(-1)
    }
    
    @warn_unused_result
    public func successor() -> UInt256 {
        return advancedBy(1)
    }
    
}

extension UInt256 : BitwiseOperationsType {}

/// Returns the intersection of bits set in `lhs` and `rhs`.
///
/// - Complexity: O(1).
@warn_unused_result
public func & (lhs: UInt256, rhs: UInt256) -> UInt256 {
    var parts = [UInt32]()
    for i in 0 ..< 8 {
        parts.append(lhs.parts[i] & rhs.parts[i])
    }
    return UInt256(parts)
}
/// Returns the union of bits set in `lhs` and `rhs`.
///
/// - Complexity: O(1).
@warn_unused_result
public func | (lhs: UInt256, rhs: UInt256) -> UInt256 {
    var parts = [UInt32]()
    for i in 0 ..< 8 {
        parts.append(lhs.parts[i] | rhs.parts[i])
    }
    return UInt256(parts)
}
/// Returns the bits that are set in exactly one of `lhs` and `rhs`.
///
/// - Complexity: O(1).
@warn_unused_result
public func ^ (lhs: UInt256, rhs: UInt256) -> UInt256 {
    var parts = [UInt32]()
    for i in 0 ..< 8 {
        parts.append(lhs.parts[i] ^ rhs.parts[i])
    }
    return UInt256(parts)
}
/// Returns `x ^ ~UInt256.allZeros`.
///
/// - Complexity: O(1).
@warn_unused_result
prefix public func ~ (x: UInt256) -> UInt256 {
    return x ^ ~UInt256.allZeros
}

extension UInt256 {
    
    public static var allZeros: UInt256 {
        return UInt256()
    }
    
}

extension NSCoder {
    
    public func encodeUInt256(unsignedInteger: UInt256, forKey key: String) {
        encodeObject(unsignedInteger.data, forKey: key)
    }
    
    public func decodeUInt256ForKey(key: String) -> UInt256 {
        guard let data = decodeObjectForKey(key) as? NSData else { return UInt256() }
        return UInt256(data: data) ?? UInt256()
    }
    
}




