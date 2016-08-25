//
//  NSSortedArray.swift
//  NoodleBox
//
//  Created by Thom Morgan on 6/29/16.
//  Copyright © 2016 NoodleOfDeath. All rights reserved.
//

// MARK: - ** Import Modules **

import Foundation

private struct CodingKeys {
    static let SortOrder = "SortOrder"
    static let Values = "Values"
}

// MARK: - ** NSSortedArray Class **

/// An array class that automatically places elements in order as
/// they added to the collection.
public class NSSortedArray <Value: Comparable> : NSObject, CollectionType, NSCoding {
    
    // MARK: - CollectionType
    
    public typealias Index = Int
    public typealias Generator = IndexingGenerator<NSSortedArray<Value>>
    
    public var startIndex: Index { return 0 }
    public var endIndex: Index { return values.count }
    public var range: Range<Index> { return 0 ..< values.count }
    public var count: Int { return values.count }
    
    // MARK: - CustomStringConvertible
    
    public override var description: String { return "\(values)" }
    
    // MARK: - NSSortedArray
    
    /// The order in which to sort array elements.
    public var sortOrder: SortOrder {
        willSet { if sortOrder != newValue { values = values.reverse() } }
    }
    
    /// The elements of this array.
    public private (set) var values = [Value]()
    
    /// Whether or not to allow duplicate elements to be added to this array.
    public var uniqueElements: Bool = true
    
    // MARK: - ** Constructor Methods **
    
    // MARK: - NSSortedArray
    
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
    public init(_ sortedArray: NSSortedArray<Value>) {
        sortOrder = sortedArray.sortOrder
        values = sortedArray.values
    }
    
    /// Bridging constructor from a `SortedArray` structure instance.
    /// - parameter sortedArray: Another array to initialize from.
    /// - returns: An array class instance with sorted values
    /// identical to `sortedArray`.
    public init(_ sortedArray: SortedArray<Value>) {
        sortOrder = sortedArray.sortOrder
        values = sortedArray.values
    }
    
    // MARK: - NSCoding
    
    public convenience required init?(coder aDecoder: NSCoder) {
        guard let sortOrder = SortOrder(rawValue: aDecoder.decodeIntegerForKey(CodingKeys.SortOrder)) else { return nil }
        guard let values = aDecoder.decodeObjectForKey(CodingKeys.Values) as? [Value] else { return nil }
        self.init(sortOrder: sortOrder, values: values)
    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(sortOrder.rawValue, forKey: CodingKeys.SortOrder)
        aCoder.encodeObject(values, forKey: CodingKeys.Values)
    }
    
    // MARK: - CollectionType
    
    public subscript (index: Index) -> Value {
        get { return values[index] }
        set { values[index] = newValue }
    }
    
    public func generate() -> Generator {
        return Generator(NSSortedArray(values: values))
    }
    
    /// Insert `newElement` at index `i`.
    ///
    /// - requires: `i <= count`.
    ///
    /// - complexity: O(`self.count`).
    public func insert(value: Value, atIndex index: Index) {
        values.insert(value, atIndex: index)
    }
    
    /// Remove and return the element at index `i`.
    ///
    /// Invalidates all indices with respect to `self`.
    ///
    /// - complexity: O(`self.count`).
    public func removeAtIndex(index: Index) -> Value {
        return values.removeAtIndex(index)
    }
    
    /// Remove all elements.
    ///
    /// - postcondition: `capacity == 0` iff `keepCapacity` is `false`.
    ///
    /// - complexity: O(`self.count`).
    public func removeAll(keepCapacity keepCapacity: Bool = false) {
        values.removeAll(keepCapacity: keepCapacity)
    }
    
    // MARK: - NSSortedArray
    
    /// Returns the first index where `value` appears in `self` or `nil` if
    /// `value` is not found.
    ///
    /// - note: This is a significantly less costly implementation of the
    /// default system method `indexOf(element: Element)`.
    ///
    /// - complexity: O(`log(self.count)`)
    ///
    /// - parameter value: The value to search for.
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
    /// - returns: The first index where `value` would be placed in sorted
    /// order in `self`.
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
    public func add(value: Value) -> Index? {
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
    public func remove(value: Value){
        var index = indexOf(value)
        while index != nil {
            values.removeAtIndex(index!)
            index = indexOf(value)
        }
    }
    
}