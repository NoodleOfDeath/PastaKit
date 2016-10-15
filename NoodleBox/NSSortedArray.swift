//
//  NSSortedArray.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 6/29/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

// MARK: - ** Import Modules **

import Foundation

private struct CodingKeys {
    static let SortOrder = "SortOrder"
    static let elements = "elements"
}

// MARK: - ** NSSortedArray Class **

/// An array class that automatically places elements in order as
/// they added to the collection.
public class NSSortedArray <Element: Comparable> : NSObject, Collection, NSCoding {
    
    /// Returns the position immediately after the given index.
    ///
    /// - Parameter i: A valid index of the collection. `i` must be less than
    ///   `endIndex`.
    /// - Returns: The index value immediately after `i`.
    public func index(after i: Int) -> Int {
        return i + 1
    }

    // MARK: - CollectionType
    
    public typealias Index = Int
    public typealias Iterator = IndexingIterator<NSSortedArray<Element>>
    
    public var startIndex: Index { return 0 }
    public var endIndex: Index { return elements.count }
    public var range: CountableRange<Index> { return 0 ..< elements.count }
    public var count: Int { return elements.count }
    
    // MARK: - CustomStringConvertible
    
    public override var description: String { return "\(elements)" }
    
    // MARK: - NSSortedArray
    
    /// The order in which to sort array elements.
    public var sortOrder: SortOrder { return backingStorage.sortOrder }
    
    /// The elements of this array.
    public var elements: [Element] { return backingStorage.elements }
    
    /// 
    fileprivate var backingStorage: SortedArray<Element>
    
    // MARK: - ** Constructor Methods **
    
    // MARK: - NSSortedArray
    
    /// Verbose constructor in which the sort order can be established at
    /// initialization.
    /// - parameter sortOrder: The order in which to sort array elements.
    /// - parameter elements: The initial elements to populate this array.
    /// - note: The initial elements parameter need not be sorted, as it will
    /// automatically be sorted upon initialization.
    /// - returns: An array structure instance with sorted elements.
    public init(sortOrder: SortOrder = .ascending, elements: [Element] = [Element]()) {
        backingStorage = SortedArray<Element>(sortOrder: sortOrder, elements: elements)
    }
    
    /// Convenience constructor that sets the inital array elements.
    /// - parameter elements: The initial elements to populate this array.
    /// - returns: An array structure instance with sorted elements in
    /// ascending order.
    public init(_ elements: [Element]) {
        backingStorage = SortedArray<Element>(sortOrder: .ascending, elements: elements)
    }
    
    /// Bridging constructor from a `SortedArray` structure instance.
    /// - parameter sortedArray: Another array to initialize from.
    /// - returns: An array class instance with sorted elements
    /// identical to `sortedArray`.
    public init(_ sortedArray: SortedArray<Element>) {
        backingStorage = sortedArray
    }
    
    /// Duplicating constructor.
    /// - parameter sortedArray: Another array to initialize from.
    /// - returns: An array structure instance with sorted elements
    /// identical to `sortedArray`.
    public init(_ sortedArray: NSSortedArray<Element>) {
        backingStorage = sortedArray.backingStorage
    }
    
    // MARK: - NSCoding
    
    public convenience required init?(coder aDecoder: NSCoder) {
        guard let sortOrder = SortOrder(rawValue: aDecoder.decodeInteger(forKey: CodingKeys.SortOrder)) else { return nil }
        guard let elements = aDecoder.decodeObject(forKey: CodingKeys.elements) as? [Element] else { return nil }
        self.init(sortOrder: sortOrder, elements: elements)
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(sortOrder.rawValue, forKey: CodingKeys.SortOrder)
        aCoder.encode(elements, forKey: CodingKeys.elements)
    }
    
    // MARK: - CollectionType
    
    public subscript (index: Index) -> Element {
        get { return backingStorage[index] }
        set { backingStorage[index] = newValue }
    }
    
    public func makeIterator() -> Iterator {
        return Iterator(_elements: NSSortedArray(self))
    }
    
    /// Insert `newElement` at index `i`.
    ///
    /// - requires: `i <= count`.
    ///
    /// - complexity: O(`self.count`).
    public func insert(_ element: Element, atIndex index: Index) {
        backingStorage.insert(element, atIndex: index)
    }
    
    /// Remove and return the element at index `i`.
    ///
    /// Invalidates all indices with respect to `self`.
    ///
    /// - complexity: O(`self.count`).
    public func removeAtIndex(_ index: Index) -> Element {
        return backingStorage.removeAtIndex(index)
    }
    
    /// Remove all elements.
    ///
    /// - postcondition: `capacity == 0` iff `keepCapacity` is `false`.
    ///
    /// - complexity: O(`self.count`).
    public func removeAll(keepCapacity: Bool = false) {
        backingStorage.removeAll(keepCapacity: keepCapacity)
    }
    
    // MARK: - NSSortedArray
    
    /// Returns the first index where `element` appears in `self` or `nil` if
    /// `element` is not found.
    ///
    /// - note: This is a significantly less costly implementation of the
    /// default system method `indexOf(element: Element)`.
    ///
    /// - complexity: O(`log(self.count)`)
    ///
    /// - parameter element: The element to search for.
    /// - parameter range: The range to search within. If `nil` the entire
    /// range of elements are searched.
    /// - returns: The first index where `element` appears in `self` or `nil` if
    /// `element` is not found.
    
    public func indexOf(_ element: Element, searchRange range: CountableRange<Index>? = nil) -> Index? {
        return backingStorage.indexOf(element, searchRange: range)
    }
    
    /// Returns the first index where `element` would be placed in sorted order
    /// in `self`.
    ///
    /// - complexity: O(`log(self.count)`)
    ///
    /// - parameter element: The element to search for.
    /// - parameter range: The range to search within. If `nil` the entire
    /// range of elements are searched.
    /// - returns: The first index where `element` would be placed in sorted
    /// order in `self`.
    
    public func ordinalIndexForElement(_ element: Element, searchRange range: CountableRange<Index>? = nil) -> Index {
        return backingStorage.ordinalIndexForElement(element, searchRange: range)
    }
    
    /// Adds a element to `self` in sorted order.
    /// - parameter element: The element to add.
    /// - returns: The index where `element` was inserted, or `nil` if
    /// `uniqueElements` is set to `true` and `element` already exists in
    /// `self.
    ///
    /// - complexity: O(`log(self.count)`)
    public func add(_ element: Element, offset: Int = 0) -> Index {
        return backingStorage.add(element, offset: offset)
    }
    
    /// Removes all instances of `element` from `self`
    /// - parameter element: The `element` to remove from `self`.
    ///
    /// - complexity: O(`log(self.count) * n`) where `n` is the number of
    /// times `element` occurs in `self`.
    public func remove(_ element: Element) {
        backingStorage.remove(element)
    }
    
}
