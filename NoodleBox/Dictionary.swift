//
//  Dictionary.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 4/19/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import Foundation

extension Dictionary : Equatable {}

/// Returns a Boolean value that indicates whether the contents of the
/// receiving dictionary are _not_ equal to the contents of another 
/// given dictionary.
///
/// `true` if the contents of `rhs` are not equal to the contents of
/// `lhs`, otherwise `false`.
/// - parameter lhs: The receiving dictionary.
/// - parameter rhs: Another dictionary.
/// - returns: `true` if the contents of `rhs` are not equal to the contents of
/// `lhs`, otherwise `false`.
public func != <Key, Value> (lhs: [Key : Value], rhs: [Key : Value]) -> Bool {
    return !NSDictionary(dictionary: lhs).isEqual(to: rhs)
}

/// Returns a `Boolean` value that indicates whether the contents of the
/// receiving dictionary are equal to the contents of another given dictionary.
///
/// `true` if the contents of `rhs` are equal to the contents
/// of `lhs`, otherwise `false`.
/// - parameter lhs: The receiving dictionary.
/// - parameter rhs: Another dictionary.
/// - returns: `true` if the contents of `rhs` are equal to the contents of
/// `lhs`, otherwise `false`.
public func == <Key, Value> (lhs: [Key : Value], rhs: [Key : Value]) -> Bool {
    return NSDictionary(dictionary: lhs).isEqual(to: rhs)
}

/// Add the all `keys` and `values` from `rhs` to `lhs` and return the sum.
/// - parameter lhs: Operation augend.
/// - parameter rhs: Opertaion addend.
/// - returns: A union of `lhs` and `rhs`.
public func + <Key, Value> (lhs: [Key : Value]?, rhs: [Key : Value]?) -> [Key : Value]? {
    guard var lhs = lhs else { return rhs ?? nil }
    guard let rhs = rhs else { return lhs }
    for (k, v) in rhs {
        lhs[k] = v
    }
    return lhs
}

/// Add the all `keys` and `values` from `rhs` to `lhs` and return the sum.
/// - parameter lhs: Operation augend.
/// - parameter rhs: Opertaion addend.
/// - returns: A union of `lhs` and `rhs`.
public func + <Key, Value> (lhs: [Key : Value]?, rhs: [Key : Value]) -> [Key : Value] {
    guard var lhs = lhs else { return rhs }
    for (k, v) in rhs {
        lhs[k] = v
    }
    return lhs
}

/// Add the all `keys` and `values` from `rhs` to `lhs` and return the sum.
/// - parameter lhs: Operation augend.
/// - parameter rhs: Opertaion addend.
/// - returns: A union of `lhs` and `rhs`.
public func + <Key, Value> (lhs: [Key : Value], rhs: [Key : Value]?) -> [Key : Value] {
    guard let rhs = rhs else { return lhs }
    var lhs = lhs
    for (k, v) in rhs {
        lhs[k] = v
    }
    return lhs
}

/// Add the all `keys` and `values` from `rhs` to `lhs` and return the sum.
/// - parameter lhs: Operation augend.
/// - parameter rhs: Opertaion addend.
/// - returns: A union of `lhs` and `rhs`.
public func + <Key, Value> (lhs: [Key : Value], rhs: [Key : Value]) -> [Key : Value] {
    var lhs = lhs
    for (k, v) in rhs {
        lhs[k] = v
    }
    return lhs
}

/// Add the all `keys` and `values` from `rhs` to `lhs` and assign the result
/// back into `lhs`.
/// - parameter lhs: Operation augend and assignment target.
/// - parameter rhs: Opertaion addend.
public func += <Key, Value> (lhs: inout [Key : Value]?, rhs: [Key : Value]?) {
    lhs = lhs + rhs
}

/// Add the all `keys` and `values` from `rhs` to `lhs` and assign the result
/// back into `lhs`.
/// - parameter lhs: Operation augend and assignment target.
/// - parameter rhs: Opertaion addend.
public func += <Key, Value> (lhs: inout [Key : Value]?, rhs: [Key : Value]) {
    guard let addend = lhs else { lhs = rhs; return }
    lhs = addend + rhs
}

/// Add the all `keys` and `values` from `rhs` to `lhs` and assign the result
/// back into `lhs`.
/// - parameter lhs: Operation augend and assignment target.
/// - parameter rhs: Opertaion addend.
public func += <Key, Value> (lhs: inout [Key : Value], rhs: [Key : Value]?) {
    lhs = lhs + rhs
}

/// Add the all `keys` and `values` from `rhs` to `lhs` and assign the result
/// back into `lhs`.
/// - parameter lhs: Operation augend and assignment target.
/// - parameter rhs: Opertaion addend.
public func += <Key, Value> (lhs: inout [Key : Value], rhs: [Key : Value]) {
    lhs = lhs + rhs
}

/// Bridging from `Dictionary` to `NSDictionary`
public postfix func * <T: ExpressibleByDictionaryLiteral>(argument: T) -> NSDictionary {
    return argument as! NSDictionary
}

// MARK: - ** Dictionary Subscripting Extensions ** -

extension Dictionary {

    /// Conveniently access the value associated with the given optional key.
    ///
    /// Reading a key that is not present or inputing a `nil` key yields `nil`.
    /// Writing `nil` as the value for a given key erases that key from `self`.
    public subscript (key: Key?) -> Value? {
        get {
            guard let key = key else { return nil }
            return self[key]
        }
        set {
            guard let key = key else { return }
            self[key] = newValue
        }
    }
    
    /// Conveniently access the value associated with the given optional key.
    ///
    /// Reading a key that is not present or inputing a `nil` key yields `nil`.
    /// Writing `nil` as the value for a given key erases that key from `self`.
    public subscript (key: Key?, caseInsensitive: Bool) -> Value? {
        get {
            guard let key = key , String(describing: key).lowercased().length > 0 else { return nil }
            guard caseInsensitive else { return self[key] }
            let searchKey = String(describing: key).lowercased()
            for key in keys {
                let k = String(describing: key).lowercased()
                if searchKey == k {
                    return self[key]
                }
            }
            return nil
        }
        set {
            guard let key = key , String(describing: key).lowercased().length > 0 else { return }
            guard caseInsensitive else { self[key] = newValue ; return }
            let searchKey = String(describing: key).lowercased()
            for key in keys {
                guard searchKey == String(describing: key).lowercased() else { continue }
                self[key] = newValue
                return
            }
        }
    }
    
}


