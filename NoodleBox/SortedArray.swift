//
//  SortedArray.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 8/15/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

// MARK: - ** Import Modules **

import Foundation

// MARK: - ** SortedArray Operations **

/// 
public func + <T: Comparable>(lhs: SortedArray<T>, rhs: SortedArray<T>) -> SortedArray<T> {
    var arr = lhs
    var index = 0
    for element in rhs {
        index = arr.add(element, offset: index) ?? 0
    }
    return arr
}

/// 
public func + <T: Comparable>(lhs: SortedArray<T>, rhs: [T]) -> SortedArray<T> {
    var arr = lhs
    for element in rhs {
        _ = arr.add(element)
    }
    return arr
}

/// 
public func + <T: Comparable>(lhs: SortedArray<T>, rhs: T) -> SortedArray<T> {
    var arr = lhs
    _ = arr.add(rhs)
    return arr
}

// MARK: - ** SortedArray Structure **

/// An array data structure that automatically places elements in order as
/// they added to the collection.
public struct SortedArray <Element: Comparable> : Collection, _ObjectiveCBridgeable, CustomStringConvertible {

    // MARK: - _ObjectiveCBridgeable
    
    /// Required typealias from the `_ObjectiveCBridgeable` private protocol
    public typealias _ObjectiveCType = NSSortedArray<Element>
    
    // MARK: - CollectionType
    
    public typealias Index = Int
    public typealias Iterator = IndexingIterator<SortedArray<Element>>
    
    public var startIndex: Index { return 0 }
    public var endIndex: Index { return elements.count }
    public var range: CountableRange<Index> { return 0 ..< elements.count }
    public var count: Int { return elements.count }
    
    // MARK: - CustomStringConvertible
    
    public var description: String { return elements.description }
    
    // MARK: - SortedArray
    
    /// The elements of this array.
    public fileprivate (set) var elements = [Element]()
    
    /// The order in which to sort array elements.
    public var sortOrder: SortOrder {
        willSet { if sortOrder != newValue { elements = elements.reversed() } }
    }
    
    /// Whether or not this set is surjective, default value is false.
    public let surjective: Bool
    
    // MARK: - ** Constructor Methods **
    
    // MARK: - SortedArray
    
    /// Verbose constructor in which the sort order can be established at
    /// initialization.
    /// - parameter elements: The initial elements to populate this array.
    /// - parameter sortOrder: The order in which to sort array elements.
    /// - note: The initial elements parameter need not be sorted, as it will
    /// automatically be sorted upon initialization.
    /// - returns: An array structure instance with sorted elements.
    public init(elements: [Element] = [Element](), sortOrder: SortOrder = .ascending, surjective: Bool = false) {
        self.elements = elements.sorted(by: { (a: Element, b: Element) -> Bool in
            return sortOrder == .ascending ? (a < b) : (b < a)
        })
        self.sortOrder = sortOrder
        self.surjective = surjective
    }
    
    /// Duplication constructor.
    /// - parameter sortedArray: Another array to initialize from.
    /// - returns: An array structure instance with sorted elements
    /// identical to `sortedArray`.
    public init(_ sortedArray: SortedArray<Element>) {
        sortOrder = sortedArray.sortOrder
        elements = sortedArray.elements
        surjective = sortedArray.surjective
    }
    
    /// Bridging constructor from an `NSSortedArray` class instance.
    /// - parameter sortedArray: Another array to initialize from.
    /// - returns: An array structure instance with sorted elements
    /// identical to `sortedArray`.
    public init(_ sortedArray: _ObjectiveCType) {
        sortOrder = sortedArray.sortOrder
        elements = sortedArray.elements
        surjective = sortedArray.surjective
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
    /// - returns: `NSSortedArray<Element>.self`
    public static func _getObjectiveCType() -> Any.Type {
        return _ObjectiveCType.self
    }
    
    /// Required static method from the `_ObjectiveCBridgeable` private
    /// protocol.
    /// - parameter source: An `NSSortedArray<Element>` instance to force bridge
    /// to `SortedArray<Element>`.
    /// - parameter result: The `SortedArray<Element>` instance created from
    /// the forced bridging.
    public static func _forceBridgeFromObjectiveC(_ source: _ObjectiveCType, result: inout SortedArray<Element>?) {
        result = SortedArray<Element>(source)
    }
    
    /// Required static method from the `_ObjectiveCBridgeable` private
    /// protocol.
    /// - parameter source: An `NSSortedArray<Element>` instance to conditionally
    /// bridge to `SortedArray<Element>`.
    /// - parameter result: The `SortedArray<Element>` instance created from
    /// the conditional bridging.
    public static func _conditionallyBridgeFromObjectiveC(_ source: _ObjectiveCType, result: inout SortedArray<Element>?) -> Bool {
        _forceBridgeFromObjectiveC(source, result: &result)
        return true
    }
    
    /// Required method from the `_ObjectiveCBridgeable` private protocol
    /// - returns: An `NSStortedArray<Element>` instance identical to `self`.
    public func _bridgeToObjectiveC() -> _ObjectiveCType {
        return _ObjectiveCType(self)
    }
    
    /// Bridge from an Objective-C object of the bridged class type to a
    /// value of the Self type.
    ///
    /// This bridging operation is used for unconditional bridging when
    /// interoperating with Objective-C code, either in the body of an
    /// Objective-C thunk or when calling Objective-C code, and may
    /// defer complete checking until later. For example, when bridging
    /// from `NSArray` to `Array<Element>`, we can defer the checking
    /// for the individual elements of the array.
    ///
    /// \param source The Objective-C object from which we are
    /// bridging. This optional value will only be `nil` in cases where
    /// an Objective-C method has returned a `nil` despite being marked
    /// as `_Nonnull`/`nonnull`. In most such cases, bridging will
    /// generally force the value immediately. However, this gives
    /// bridging the flexibility to substitute a default value to cope
    /// with historical decisions, e.g., an existing Objective-C method
    /// that returns `nil` to for "empty result" rather than (say) an
    /// empty array. In such cases, when `nil` does occur, the
    /// implementation of `Swift.Array`'s conformance to
    /// `_ObjectiveCBridgeable` will produce an empty array rather than
    /// dynamically failing.
    public static func _unconditionallyBridgeFromObjectiveC(_ source: _ObjectiveCType?) -> SortedArray<Element> {
        guard let source = source else { return SortedArray<Element> () }
        return SortedArray<Element>(source)
    }
    
    // MARK: - CollectionType
    
    public subscript (index: Index) -> Element {
        get { return elements[index] }
        set { elements[index] = newValue }
    }
    
    /// Returns the position immediately after the given index.
    ///
    /// - Parameter i: A valid index of the collection. `i` must be less than
    ///   `endIndex`.
    /// - Returns: The index value immediately after `i`.
    public func index(after i: Int) -> Int {
        return i + 1
    }
    
    public func makeIterator() -> Iterator {
        return Iterator(_elements: SortedArray(self))
    }
    
    /// Insert `newElement` at index `i`.
    ///
    /// - requires: `i <= count`.
    ///
    /// - complexity: O(`self.count`).
    public mutating func insert(_ element: Element, atIndex index: Index) {
        elements.insert(element, at: index)
    }
    
    /// Remove and return the element at index `i`.
    ///
    /// Invalidates all indices with respect to `self`.
    ///
    /// - complexity: O(`self.count`).
    public mutating func removeAtIndex(_ index: Index) -> Element {
        return elements.remove(at: index)
    }
    
    /// Remove all elements.
    ///
    /// - postcondition: `capacity == 0` iff `keepCapacity` is `false`.
    ///
    /// - complexity: O(`self.count`).
    public mutating func removeAll(keepCapacity: Bool = false) {
        elements.removeAll(keepingCapacity: keepCapacity)
    }
    
    // MARK: - SortedArray
    
    /// Returns the first index where `element` appears in `self` or `nil` if
    /// `element` is not found.
    ///
    /// - note: This is a significantly less costly implementation of the
    /// default system method `indexOf(element: Element)`.
    ///
    /// - complexity: O(`log(self.count)`)
    ///
    /// - parameter element: The element to search for
    /// - parameter range: The range to search within. If `nil` the entire
    /// range of elements are searched.
    /// - returns: The first index where `element` appears in `self` or `nil` if
    /// `element` is not found.
    
    public func indexOf(_ element: Element, searchRange range: CountableRange<Index>? = nil) -> Index? {
        
        if elements.count == 0 { return nil }
        
        let range = range ?? 0 ..< elements.count
        let index = (range.lowerBound + range.length / 2)
        let val = elements[index]
        
        if range.length == 1 {
            return val == element ? index : nil
        } else if (val > element && sortOrder == .ascending) || (val < element && sortOrder == .descending) {
            return indexOf(element, searchRange: range.lowerBound ..< index)
        }
        
        return indexOf(element, searchRange: index ..< range.upperBound)
        
    }
    
    /// Returns the first index where `element` would be placed in sorted order
    /// in `self`.
    ///
    /// - complexity: O(`log(self.count)`)
    ///
    /// - parameter element: The element to search for.
    /// - parameter range: The range to search within. If `nil` the entire
    /// range of elements are searched.
    /// - returns: Returns the first index where `element` would be placed
    /// in sorted order.
    
    public func ordinalIndexForElement(_ element: Element, searchRange range: CountableRange<Index>? = nil) -> Index {
        
        if elements.count == 0 { return 0 }
        
        let range = range ?? 0 ..< elements.count
        let index = (range.lowerBound + range.length / 2)
        let val = elements[index]
        
        if range.length == 1 {
            return (val > element && sortOrder == .ascending) || (val < element && sortOrder == .descending) ? index : index + 1
        } else if (val > element && sortOrder == .ascending) || (val < element && sortOrder == .descending) {
            return ordinalIndexForElement(element, searchRange: range.lowerBound ..< index)
        }
        
        return ordinalIndexForElement(element, searchRange: index ..< range.upperBound)
        
    }
    
    /// Adds a element to `self` in sorted order.
    /// - parameter element: The element to add.
    /// - returns: The index where `element` was inserted, or `nil` if
    /// `uniqueElements` is set to `true` and `element` already exists in
    /// `self.
    ///
    /// - complexity: O(`log(self.count)`)
    public mutating func add(_ element: Element, offset: Int = 0) -> Index? {
        var index = 0
        if elements.count == 0 { elements.append(element) }
        else {
            if surjective && elements.contains(element) { return nil }
            index = ordinalIndexForElement(element, searchRange: offset ..< endIndex)
            elements.insert(element, at: index)
        }
        return index
    }
    
    /// Removes all instances of `element` from `self`
    /// - parameter element: The `element` to remove from `self`.
    ///
    /// - complexity: O(`log(self.count) * n`) where `n` is the number of
    /// times `element` occurs in `self`.
    public mutating func remove(_ element: Element){
        var index = indexOf(element)
        while index != nil {
            elements.remove(at: index!)
            index = indexOf(element)
        }
    }
    
}
