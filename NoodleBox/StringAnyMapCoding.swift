//
//  DictionaryCoding.swift
//  NoodleBox
//
//  Created by Thom Morgan on 10/15/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import Foundation

/// 
/// 
public protocol DictionaryCoding {
    associatedtype Key: Hashable
    associatedtype Value: Any
    init?(dict: [Key : Value])
    var dictionaryForm: [Key : Value] { get }
}

extension NSCoder {
    
    /// Encodes a `DictionaryCoding` data structure.
    /// - important: The object dictionaryForm being encoded to must conform to
    /// `NSCoding`.
    /// - parameter object: The object to encode.
    open func encode<T: DictionaryCoding>(_ object: T?) {
        encode(object?.dictionaryForm)
    }
    
    /// Encodes a `DictionaryCoding` data structure as a root object.
    /// - important: The object dictionaryForm being encoded to must conform to
    /// `NSCoding`.
    /// - parameter object: The object to encode.
    open func encodeRootObject<T: DictionaryCoding>(_ object: T) {
        encodeRootObject(object.dictionaryForm)
    }
    
    /// Encodes a `DictionaryCoding` conditional data structure.
    /// - important: The object dictionaryForm being encoded to must conform to
    /// `NSCoding`.
    /// - parameter object: The object to encode.
    open func encodeConditionalObject<T: DictionaryCoding>(_ object: T?) {
        encodeConditionalObject(object?.dictionaryForm)
    }
    
    /// Encodes a `DictionaryCoding` data structure and maps it to a 
    /// specific `key`.
    /// - important: The object dictionaryForm being encoded to must conform to
    /// `NSCoding`.
    /// - parameter object: The object to encode.
    /// - parameter key: The key to associate with this object.
    open func encode<T: DictionaryCoding>(_ object: T?, forKey key: String) {
        encode(object?.dictionaryForm, forKey: key)
    }
    
    /// Encodes a `DictionaryCoding` conditional data structure and maps
    /// it to a specific `key`.
    /// - important: The object dictionaryForm being encoded to must conform to
    /// `NSCoding`.
    /// - parameter object: The object to encode.
    /// - parameter key: The key to associate with this object.
    open func encodeConditionalObject<T: DictionaryCoding>(_ object: T?, forKey key: String) {
        encodeConditionalObject(object?.dictionaryForm, forKey: key)
    }
    
}
