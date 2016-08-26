//
//  SortedArray.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 8/15/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

// MARK: - ** Import Modules **

import Foundation

// MARK: - ** SortOrder Enumeration **

/// Ascending or descending sort order enumerations
public enum SortOrder : Int {
    case Ascending, Descending
}

// MARK: - ** SortedArray Structure **

/// An array data structure that automatically places elements in order as
/// they added to the collection.
public struct SortedArray <Value: Comparable> : CollectionType, _ObjectiveCBridgeable, CustomStringConvertible {
    
    // MARK: - _ObjectiveCBridgeable
    
    /// Required typealias from the `_ObjectiveCBridgeable` private protocol
    public typealias _ObjectiveCType = NSSortedArray<Value>
    
    // MARK: - CollectionType
    
    public typealias Index = Int
    public typealias Generator = IndexingGenerator<SortedArray<Value>>
    
    public var startIndex: Index { return 0 }
    public var endIndex: Index { return values.count }
    public var range: Range<Index> { return 0 ..< values.count }
    public var count: Int { return values.count }
    
    // MARK: - CustomStringConvertible
    
    public var description: String { return "\(values)" }
    
    // MARK: - SortedArray
    
    /// The order in which to sort array elements.
    public var sortOrder: SortOrder {
        willSet { if sortOrder != newValue { values = values.reverse() } }
    }
    
    /// The elements of this array.
    public private (set) var values = [Value]()
    
    /// Whether or not to allow duplicate elements to be added to this array.
    public var uniqueElements: Bool = true
    
    // MARK: - ** Constructor Methods **
    
    // MARK: - SortedArray
    
    /// Verbose constructor in which the sort order can be established at
    /// initialization.
    /// - parameter sortOrder: The order in which to sort array elements.
    /// - parameter values: The initial elements to populate this array.
    /// - note: The initial values parameter need not be sorted, as it will
    /// automatically be sorted upon initialization.
    /// - returns: An array structure instance with sorted values.
    public init(sortOrder: SortOrder = .Ascending, values: [Value] = [Value]()) {
        self.sortOrder = sortOrder
        self.values = values.sort({ (a: Value, b: Value) -> Bool in
            return sortOrder == .Ascending ? (a < b) : (b < a)
        })
    }
    
    /// Convenience constructor that sets the inital array elements.
    /// - parameter values: The initial elements to populate this array.
    /// - returns: An array structure instance with sorted values in
    /// ascending order.
    public init(_ values: [Value]) {
        sortOrder = .Ascending
        self.values = values.sort({ (a: Value, b: Value) -> Bool in
            return a < b
        })
    }
    
    /// Duplicating constructor.
    /// - parameter sortedArray: Another array to initialize from.
    /// - returns: An array structure instance with sorted values
    /// identical to `sortedArray`.
    public init(_ sortedArray: SortedArray<Value>) {
        sortOrder = sortedArray.sortOrder
        values = sortedArray.values
    }
    
    /// Bridging constructor from an `NSSortedArray` class instance.
    /// - parameter sortedArray: Another array to initialize from.
    /// - returns: An array structure instance with sorted values
    /// identical to `sortedArray`.
    public init(_ sortedArray: NSSortedArray<Value>) {
        sortOrder = sortedArray.sortOrder
        values = sortedArray.values
    }
    
    // MARK: - ** Public Methods **
    
    // MARK: - _ObjectiveCBridgeable
    
    /// Required static method from the `_ObjectiveCBridgeable` private
    /// protocol.
    /// - returns: `true`, indicating that this structure is bridgeable to
    /// an Objective-C class, namely `NSSortedArray`.
    public static func _isBridgedToObjectiveC() -> Bool {
        return true
    }
    
    /// Required static method from the `_ObjectiveCBridgeable` private
    /// protocol.
    /// - returns: `NSSortedArray<Value>.self`
    public static func _getObjectiveCType() -> Any.Type {
        return _ObjectiveCType.self
    }
    
    /// Required static method from the `_ObjectiveCBridgeable` private
    /// protocol.
    /// - parameter source: An `NSSortedArray<Value>` instance to force bridge
    /// to `SortedArray<Value>`.
    /// - parameter result: The `SortedArray<Value>` instance created from
    /// the forced bridging.
    public static func _forceBridgeFromObjectiveC(source: _ObjectiveCType, inout result: SortedArray<Value>?) {
        result = SortedArray<Value>(source)
    }
    
    /// Required static method from the `_ObjectiveCBridgeable` private
    /// protocol.
    /// - parameter source: An `NSSortedArray<Value>` instance to conditionally
    /// bridge to `SortedArray<Value>`.
    /// - parameter result: The `SortedArray<Value>` instance created from
    /// the conditional bridging.
    public static func _conditionallyBridgeFromObjectiveC(source: _ObjectiveCType, inout result: SortedArray<Value>?) -> Bool {
        _forceBridgeFromObjectiveC(source, result: &result)
        return true
    }
    
    /// Required method from the `_ObjectiveCBridgeable` private protocol
    /// - returns: An `NSStortedArray<Value>` instance identical to `self`.
    public func _bridgeToObjectiveC() -> _ObjectiveCType {
        return NSSortedArray<Value>(self)
    }
    
    // MARK: - CollectionType
    
    public subscript (index: Index) -> Value {
        get { return values[index] }
        set { values[index] = newValue }
    }
    
    public func generate() -> Generator {
        return Generator(SortedArray(values: values))
    }
    
    /// Insert `newElement` at index `i`.
    ///
    /// - requires: `i <= count`.
    ///
    /// - complexity: O(`self.count`).
    public mutating func insert(value: Value, atIndex index: Index) {
        values.insert(value, atIndex: index)
    }
    
    /// Remove and return the element at index `i`.
    ///
    /// Invalidates all indices with respect to `self`.
    ///
    /// - complexity: O(`self.count`).
    public mutating func removeAtIndex(index: Index) -> Value {
        return values.removeAtIndex(index)
    }
    
    /// Remove all elements.
    ///
    /// - postcondition: `capacity == 0` iff `keepCapacity` is `false`.
    ///
    /// - complexity: O(`self.count`).
    public mutating func removeAll() {
        values.removeAll()
    }
    
    // MARK: - SortedArray
    
    /// Returns the first index where `value` appears in `self` or `nil` if
    /// `value` is not found.
    ///
    /// - note: This is a significantly less costly implementation of the
    /// default system method `indexOf(element: Element)`.
    ///
    /// - complexity: O(`log(self.count)`)
    ///
    /// - parameter value: The value to search for
    /// - parameter range: The range to search within. If `nil` the entire
    /// range of elements are searched.
    /// - returns: The first index where `value` appears in `self` or `nil` if
    /// `value` is not found.
    @warn_unused_result
    public func indexOf(value: Value, searchRange range: Range<Index>? = nil) -> Index? {
        
        if values.count == 0 { return nil }
        
        let range = range ?? 0 ..< values.count
        let index = (range.startIndex + range.length / 2)
        let val = values[index]
        
        if range.length == 1 {
            return val == value ? index : nil
        } else if (val > value && sortOrder == .Ascending) || (val < value && sortOrder == .Descending) {
            return indexOf(value, searchRange: range.startIndex ..< index)
        }
        
        return indexOf(value, searchRange: index ..< range.endIndex)
        
    }
    
    /// Returns the first index where `value` would be placed in sorted order
    /// in `self`.
    ///
    /// - complexity: O(`log(self.count)`)
    ///
    /// - parameter value: The value to search for.
    /// - parameter range: The range to search within. If `nil` the entire
    /// range of elements are searched.
    /// - returns: Returns the first index where `value` would be placed
    /// in sorted order.
    @warn_unused_result
    public func ordinalIndexForValue(value: Value, searchRange range: Range<Index>? = nil) -> Index {
        
        if values.count == 0 { return 0 }
        
        let range = range ?? 0 ..< values.count
        let index = (range.startIndex + range.length / 2)
        let val = values[index]
        
        if range.length == 1 {
            return (val > value && sortOrder == .Ascending) || (val < value && sortOrder == .Descending) ? index : index + 1
        } else if (val > value && sortOrder == .Ascending) || (val < value && sortOrder == .Descending) {
            return ordinalIndexForValue(value, searchRange: range.startIndex ..< index)
        }
        
        return ordinalIndexForValue(value, searchRange: index ..< range.endIndex)
        
    }
    
    /// Adds a value to `self` in sorted order.
    /// - parameter value: The value to add.
    /// - returns: The index where `value` was inserted, or `nil` if
    /// `uniqueElements` is set to `true` and `value` already exists in
    /// `self.
    ///
    /// - complexity: O(`log(self.count)`)
    public mutating func add(value: Value) -> Index? {
        var index = 0
        if values.count == 0 { values.append(value) }
        else {
            if uniqueElements && indexOf(value) != nil { return nil }
            index = ordinalIndexForValue(value)
            values.insert(value, atIndex: index)
        }
        return index
    }
    
    /// Removes all instances of `value` from `self`
    /// - parameter value: The `value` to remove from `self`.
    ///
    /// - complexity: O(`log(self.count) * n`) where `n` is the number of
    /// times `value` occurs in `self`.
    public mutating func remove(value: Value){
        var index = indexOf(value)
        while index != nil {
            values.removeAtIndex(index!)
            index = indexOf(value)
        }
    }
    
}