//
//  Comparable.swift
//  NoodleBox
//
//  Created by Thom Morgan on 10/20/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import Foundation

/// 
public func < <T : Comparable> (lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

///
public func <= <T : Comparable> (lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l <= r
    default:
        return (lhs < rhs)
    }
}

/// 
public func > <T : Comparable> (lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    case (nil, _?):
        return true
    default:
        return false
    }
}

///
public func >= <T : Comparable> (lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l >= r
    default:
        return (lhs > rhs)
    }
}
