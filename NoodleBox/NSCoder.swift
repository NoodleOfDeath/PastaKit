//
//  NSCoder.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 8/15/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

// MARK: - ** Import Modules **

import Foundation

// MARK: - ** NSCoder _ObjectiveCBridgeable Encoding Compatabiltiy **

extension NSCoder {
    
    /// Encodes an `_ObjectiveCBridgeable` data structure.
    /// - important: The objective-c class being bridged to must conform to
    /// `NSCoding`.
    /// - parameter object: The object to encode.
    public func encodeObject<T: _ObjectiveCBridgeable>(object: T?) {
        encodeObject(object?._bridgeToObjectiveC())
    }
    
    /// Encodes an `_ObjectiveCBridgeable` data structure as a root object.
    /// - important: The objective-c class being bridged to must conform to
    /// `NSCoding`.
    /// - parameter object: The object to encode.
    public func encodeRootObject<T: _ObjectiveCBridgeable>(object: T) {
        encodeRootObject(object._bridgeToObjectiveC())
    }
    
    /// Encodes an `_ObjectiveCBridgeable` conditional data structure.
    /// - important: The objective-c class being bridged to must conform to
    /// `NSCoding`.
    /// - parameter object: The object to encode.
    public func encodeConditionalObject<T: _ObjectiveCBridgeable>(object: T?) {
        encodeConditionalObject(object?._bridgeToObjectiveC())
    }
    
    /// Encodes an `_ObjectiveCBridgeable` data structure and maps it to a 
    /// specific `key`.
    /// - important: The objective-c class being bridged to must conform to
    /// `NSCoding`.
    /// - parameter object: The object to encode.
    /// - parameter key: The key to associate with this object.
    public func encodeObject<T: _ObjectiveCBridgeable>(object: T?, forKey key: String) {
        encodeObject(object?._bridgeToObjectiveC(), forKey: key)
    }
    
    /// Encodes an `_ObjectiveCBridgeable` conditional data structure and maps
    /// it to a specific `key`.
    /// - important: The objective-c class being bridged to must conform to
    /// `NSCoding`.
    /// - parameter object: The object to encode.
    /// - parameter key: The key to associate with this object.
    public func encodeConditionalObject<T: _ObjectiveCBridgeable>(object: T?, forKey key: String) {
        encodeConditionalObject(object?._bridgeToObjectiveC(), forKey: key)
    }
    
}



