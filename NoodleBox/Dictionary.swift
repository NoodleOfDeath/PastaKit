//
//  Dictionary.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 4/19/16.
//  Copyright © 2016 NoodleOfDeath. All rights reserved.
//

import Foundation

public typealias PropertyList = [String : AnyObject]
public typealias Hashtable = [NSObject : AnyObject]

public func == (lhs: Hashtable, rhs: Hashtable) -> Bool {
    return NSDictionary(dictionary: lhs).isEqualToDictionary(rhs)
}

public func != (lhs: Hashtable, rhs: Hashtable) -> Bool {
    return !NSDictionary(dictionary: lhs).isEqualToDictionary(rhs)
}

public func + <Key, Value> (lhs: [Key : Value]?, rhs: [Key : Value]?) -> [Key : Value]? {
    guard var lhs = lhs else { return rhs ?? nil }
    guard let rhs = rhs else { return lhs }
    for (k, v) in rhs {
        lhs[k] = v
    }
    return lhs
}

public func + <Key, Value> (lhs: [Key : Value]?, rhs: [Key : Value]) -> [Key : Value] {
    guard var lhs = lhs else { return rhs }
    for (k, v) in rhs {
        lhs[k] = v
    }
    return lhs
}

public func + <Key, Value> (lhs: [Key : Value], rhs: [Key : Value]?) -> [Key : Value] {
    guard let rhs = rhs else { return lhs }
    var lhs = lhs
    for (k, v) in rhs {
        lhs[k] = v
    }
    return lhs
}

public func + <Key, Value> (lhs: [Key : Value], rhs: [Key : Value]) -> [Key : Value] {
    var lhs = lhs
    for (k, v) in rhs {
        lhs[k] = v
    }
    return lhs
}

public func += <Key, Value> (inout lhs: [Key : Value]?, rhs: [Key : Value]?) {
    lhs = lhs + rhs
}

public func += <Key, Value> (inout lhs: [Key : Value]?, rhs: [Key : Value]) {
    guard let addend = lhs else { lhs = rhs; return }
    lhs = addend + rhs
}

public func += <Key, Value> (inout lhs: [Key : Value], rhs: [Key : Value]?) {
    lhs = lhs + rhs
}

public func += <Key, Value> (inout lhs: [Key : Value], rhs: [Key : Value]) {
    lhs = lhs + rhs
}

public postfix func ~ <T: DictionaryLiteralConvertible>(argument: T) -> NSDictionary {
    return argument as! NSDictionary
}

/**

 */
extension Dictionary {

    public subscript (key: Key?) -> Value? {
        guard let key = key else { return nil }
        return self[key]
    }
    
}


