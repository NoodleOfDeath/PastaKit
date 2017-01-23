//
//  CFRawRepresentable.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 8/13/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

// MARK: - ** Import Modules **

import Foundation

// MARK: - ** CFRawRepresentable Protocol ** -

/// This protocol maps Swift data structures to analagous Core Foundation data
/// structures allowing the structure to be instantiated by either the Swift
/// `RawValue` associated type inherited from `RawRepresentable` or the Core
/// Foundation `CoreValue` associated type.
public protocol CFRawRepresentable : RawRepresentable {
    
    // MARK: - ** Associated Types **
    
    /// A Core Foundation data structure type (i.e. CFString)
    associatedtype CoreValue
    
    // MARK: - ** Static Properties **
    
    /// The default Swift form of this data structure
    static var DefaultRawValue: RawValue { get}
    
    /// The default Core Foundation form of this data structure
    static var DefaultCoreValue: CoreValue { get}
    
    // MARK: ** Public Properties **
    
    /// The Core Foundation form of this data structure
    var coreValue: CoreValue { get }
    
    // MARK: - ** Constructor Methods **
    
    /// Convenience constructor method
    /// - parameter rawValue: The Swift `RawValue` form of this data structure
    init(_ rawValue: RawValue)
    
    /// Convenience constructor method.
    ///
    /// - parameter rawValue?: The optional Swift `RawValue` form of this 
    /// data structure
    init?(_ rawValue: RawValue?)
    
    /// Convenience constructor method
    /// - parameter coreValue: The Core Foundation `CoreValue` form of this
    /// data structure
    init(_ coreValue: CoreValue)
    
    /// Convenience constructor method.
    ///
    /// - parameter coreValue?: The optional Core Foundation `CoreValue` form
    /// of this data structure
    init?(_ coreValue: CoreValue?)
    
}

extension CFRawRepresentable {
    
    /// Default optional convenience constructor method that handles an
    /// optional initial value parameter.
    /// - parameter rawValue: An optional initial raw value
    /// - returns: A `CFRawRepresentable` object initialized to `rawValue`
    /// if `rawValue` is not optional; `nil` otherwise.
    public init?(_ rawValue: RawValue?) {
        guard let rawValue = rawValue else { return nil }
        self.init(rawValue)
    }
    
    /// Default optional convenience constructor method that handles an
    /// optional initial value parameter.
    /// - parameter coreValue: An optional initial core value
    /// - returns: A `CFRawRepresentable` object initialized to `coreValue`
    /// if `coreValue` is not optional; `nil` otherwise.
    public init?(_ coreValue: CoreValue?) {
        guard let coreValue = coreValue else { return nil }
        self.init(coreValue)
    }
    
}


