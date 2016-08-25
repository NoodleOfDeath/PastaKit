//
//  Range.swift
//  NoodleBox
//
//  Created by Thom Morgan on 6/29/16.
//  Copyright © 2016 NoodleOfDeath. All rights reserved.
//

import Foundation

public typealias IntRange = Range<Int>

public postfix func ~ (argument: IntRange) -> NSRange {
    return NSMakeRange(argument.startIndex, argument.length)
}

public postfix func ~ (argument: NSRange) -> IntRange {
    return argument.location ..< argument.maxRange
}

extension Range where Element : IntegerType {
    
    public var length: Element {
        return endIndex - startIndex
    }
    
}
