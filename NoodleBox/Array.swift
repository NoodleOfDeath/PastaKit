//
// Array.swift
// NoodleBox
//
// Created by NoodleOfDeath on 4/12/16.
// Copyright © 2016 NoodleNation. All rights reserved.
//

import Foundation

public typealias AnyArray = [Any]
public typealias AnyObjectArray = [AnyObject]

///
public func + <Element>(lhs: [Element]?, rhs: [Element]) -> [Element] {
    return (lhs ?? []) + rhs
}

///
public func + <Element>(lhs: [Element], rhs: [Element]?) -> [Element] {
    return lhs + (rhs ?? [])
}

///
public func + <Element>(lhs: [Element]?, rhs: [Element]?) -> [Element]? {
    if let lhs = lhs {
        return (lhs + rhs) as [Element]
    }
    if let rhs = rhs {
        return (lhs + rhs) as [Element]
    }
    return nil
}

///
public postfix func * <Element: Any>(argument: [Element]) -> NSArray {
    return argument as NSArray
}

///
public postfix func * <Element: Any>(argument: [Element]?) -> NSArray? {
    return argument as NSArray?
}

extension Array {
    
    /// The range representation of this array.
    public var range: NSRange {
        return NSMakeRange(0, count - 1)
    }
    
}

extension Array {
    
    /// Returns whether or not the specified index is within the index
    /// bounds of this array.
    /// - parameter index: an index
    /// - returns: `true` if `index` is within the bounds of this array.
    /// `false` otherwise.
    public func contains(index: Int) -> Bool {
        return index >= 0 && index < count
    }
    
}

extension Array {
    
    /// Alias of `removeFirst()`
    public mutating func pop() -> Element? {
        return removeFirst()
    }
    
    /// Conditional alias of `append(element: Element)`.
    /// - parameter element: 
    /// - complexity: Amortized O(1) unless self's storage is shared with another 
    /// live array; O(count) if self does not wrap a bridged NSArray; 
    /// otherwise the efficiency is unspecified..
    public mutating func append(_ element: Element?) {
        guard let element = element else { return }
        append(element)
    }
    
    /// Alias of `append(element: Element)` with variable arity parameters.
    /// - complexity: Amortized O(n) unless self's storage is shared with another 
    /// live array; O(count) if self does not wrap a bridged NSArray; 
    /// otherwise the efficiency is unspecified. `n` is the number of elements
    /// being appeneded.
    public mutating func append(_ element: Element, _ anotherElement: Element, _ elements: Element...) {
        append(element)
        append(anotherElement)
        for element in elements { append(element) }
    }
    
    /// Pushes an element onto the stack, at index 0.
    public mutating func push(_ element: Element?) {
        guard let element = element else { return }
        insert(element, at: 0)
    }
    
    /// Pushes elements onto the stack, at index 0, in FIFO fashion.
    /// - parameter elements: The elements to push onto the stack.
    public mutating func push(_ elements: [Element]) {
        for element in elements { push(element) }
    }
    
    /// Pushes elements onto the stack, at index 0, in FIFO fashion.
    public mutating func push(_ element: Element, _ anotherElement: Element, _ elements: Element...) {
        push(element)
        push(anotherElement)
        push(elements)
    }
    
}

extension Array where Element : Equatable {

    /// Appends an `element` to `self` iff `element` is not already
    /// contained in `self`.
    /// - parameter element: An `element` to append to `self`.
    public mutating func appendUnique(_ elements: Element...) {
        for element in elements where !contains(element) {
            append(element)
        }
    }
    
    /// 
    public mutating func appendUnique(_ elements: [Element]) {
        for element in elements { appendUnique(element) }
    }
    
    /// Removes _all_ instances of `element` from `self`.
    /// - parameter element: The `element` to remove from `self.
    /// - returns: The number of occurrences of `element` that were removed
    /// form self.
    public mutating func remove(_ element: Element) -> Int {
        var occurrences = 0
        for index in (0 ..< count).reversed() {
            guard self[index] == element else { continue }
            self.remove(at: index)
            occurrences += 1
        }
        return occurrences
    }
    
}

