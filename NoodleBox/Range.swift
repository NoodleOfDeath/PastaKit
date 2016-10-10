//
//  Range.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 6/29/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import Foundation

/// 
public postfix func * (argument: Range<Int>) -> NSRange {
    return NSMakeRange(argument.lowerBound, argument.length)
}

/// 
public postfix func * (argument: NSRange) -> CountableRange<Int> {
    return argument.location ..< argument.maxRange
}

extension Range where Element : Integer {
    
    /// 
    public var length: Element { return upperBound - lowerBound }
    
}
