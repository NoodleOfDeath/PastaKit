//
//  Array.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 4/12/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import Foundation

public func + <T>(lhs: [T]?, rhs: [T]) -> [T] {
    return (lhs ?? []) + rhs
}

public func + <T>(lhs: [T], rhs: [T]?) -> [T] {
    return lhs + (rhs ?? [])
}

public func + <T>(lhs: [T]?, rhs: [T]?) -> [T]? {
    if let lhs = lhs {
        return (lhs + rhs) as [T]
    }
    if let rhs = rhs {
        return (lhs + rhs) as [T]
    }
    return nil
}

public postfix func ~ <T: AnyObject>(argument: [T]) -> NSArray {
    return argument
}

public postfix func ~ <T: AnyObject>(argument: [T]?) -> NSArray? {
    return argument
}

extension Array {
    
    public var range: NSRange {
        return NSMakeRange(0, count - 1)
    }
    
    public mutating func pop() -> Element? {
        return removeFirst()
    }
    
    public mutating func append(element: Element, _ anotherElement: Element, _ elements: Element...) {
        append(element)
        append(anotherElement)
        for element in elements {
            append(element)
        }
    }
    
    public mutating func append(element: Element?) {
        guard let element = element else { return }
        append(element)
    }
    
    public mutating func push(element: Element, _ anotherElement: Element, _ elements: Element...) {
        push(element)
        push(anotherElement)
        for element in elements {
            push(element)
        }
    }
    
    public mutating func push(element: Element) {
        insert(element, atIndex: 0)
    }
    
    public mutating func push(element: Element?) {
        guard let element = element else { return }
        insert(element, atIndex: 0)
    }
    
}

extension Array where Element : Equatable {

    public mutating func appendUnique(element: Element) {
        if !contains(element) {
            append(element)
        }
    }
    
    public mutating func remove(element: Element) -> Int {
        var occurrences = 0
        for index in (0 ..< count).reverse() {
            if self[index] == element {
                removeAtIndex(index)
                occurrences += 1
            }
        }
        return occurrences
    }
    
}

