//
//  NSUserDefaults.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 6/2/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

// MARK: - ** Import Modules **

import UIKit

// MARK: - ** Public Operations ** -

/// Merges preferences from `rhs` with the data from `lhs`.
/// If a preference key already exists in `lhs` the value will be overwritten
/// by the value for that key in `rhs`.
/// - parameter lhs: The user defaults object to update
/// - parameter rhs: The property list containing new preferences
/// - returns: A user defaults object with data that has been merged with the
/// data from `rhs`.
public func + (lhs: NSUserDefaults, rhs: PropertyList) -> NSUserDefaults {
    for (k, v) in rhs { lhs[k] = v }
    return lhs
}

/// Merges preferences from `rhs` into the `lhs` user defaults object.
/// If a preference key already exists in `lhs` the value will be overwritten
/// by the value for that key in `rhs`.
/// - parameter lhs: The user defaults object to update
/// - parameter rhs: The property list containing new preferences
public func += (inout lhs: NSUserDefaults, rhs: PropertyList) {
    for (k, v) in rhs { lhs[k] = v }
}

// MARK: - ** NSUserDefaults Subscripting ** -

extension NSUserDefaults {

    /// Convenient subscripting access to/assignment of values via `key`
    public subscript (key: String) -> AnyObject? {
        get { return objectForKey(key) }
        set { setObject(newValue, forKey: key) }
    }

}