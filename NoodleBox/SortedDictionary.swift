//
//  SortedDictionary.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 8/15/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import Foundation

/// 
public struct SortedDictionary <Key: Comparable, Value> : Collection, _ObjectiveCBridgeable {
    
    /// Returns the position immediately after the given index.
    ///
    /// - Parameter i: A valid index of the collection. `i` must be less than
    ///   `endIndex`.
    /// - Returns: The index value immediately after `i`.
    public func index(after i: Int) -> Int {
        return i + 1
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
    /// - parameter source: The Objective-C object from which we are
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
    public static func _unconditionallyBridgeFromObjectiveC(_ source: NSSortedDictionary<Key, Value>?) -> SortedDictionary<Key, Value> {
        guard let source = source else { return SortedDictionary<Key, Value>() }
        return SortedDictionary<Key, Value>(source)
    }
    
    public typealias _ObjectiveCType = NSSortedDictionary<Key, Value>
    
    public typealias Index = Int
    public typealias Iterator = IndexingIterator<SortedDictionary<Key, Value>>
    
    public var startIndex: Index { return 0 }
    public var endIndex: Index { return values.count }
    public var count: Int { return values.count }
    
    /// 
    public typealias Element = (key: Key, value: Value)
    /// 
    public let sortOrder: SortOrder
    /// 
    public fileprivate (set) var keys = SortedArray<Key>()
    /// 
    public fileprivate (set) var values = [Value]()
    
    // MARK: - ** Constructor Methods **
    
    /// 
    public init(sortOrder: SortOrder = .ascending, keys: SortedArray<Key>? = nil, values: [Value] = []) {
        self.sortOrder = sortOrder
        self.keys = keys ?? SortedArray<Key>(sortOrder: sortOrder)
        self.values = values
    }
    
    /// 
    public init(_ sortedDictionary: NSSortedDictionary<Key, Value>) {
        self.sortOrder = sortedDictionary.sortOrder
        self.keys = sortedDictionary.keys
        self.values = sortedDictionary.values
    }
    
    /// 
    public init(_ sortedDictionary: SortedDictionary<Key, Value>) {
        self.sortOrder = sortedDictionary.sortOrder
        self.keys = sortedDictionary.keys
        self.values = sortedDictionary.values
    }
    
    // MARK: - ** Protocol Methods (_ObjectiveCBridgeable) **
    
    public static func _isBridgedToObjectiveC() -> Bool {
        return true
    }
    
    public static func _getObjectiveCType() -> Any.Type {
        return _ObjectiveCType.self
    }
    
    public static func _forceBridgeFromObjectiveC(_ source: _ObjectiveCType, result: inout SortedDictionary<Key, Value>?) {
        result = SortedDictionary<Key, Value>(source)
    }
    
    public static func _conditionallyBridgeFromObjectiveC(_ source: _ObjectiveCType, result: inout SortedDictionary<Key, Value>?) -> Bool {
        _forceBridgeFromObjectiveC(source, result: &result)
        return true
    }
    
    public func _bridgeToObjectiveC() -> _ObjectiveCType {
        return NSSortedDictionary<Key, Value>(self)
    }
    
    // MARK: - ** Subscript Methods **
    
    /// 
    public subscript (position: Index) -> Element {
        get { return (keys[position], values[position]) }
        set { (keys[position], values[position]) = newValue }
    }
    
    /// 
    public subscript (key: Key) -> Value? {
        get {
            guard let index = keys.indexOf(key) else { return nil }
            return values[index]
        }
        set {
            if let index = keys.indexOf(key) {
                if let newValue = newValue {
                    values[index] = newValue
                } else {
                    _ = keys.removeAtIndex(index)
                    values.remove(at: index)
                }
            } else {
                if let newValue = newValue {
                    let index = keys.add(key)
                    values.insert(newValue, at: index)
                }
            }
        }
    }
    
    /// 
    public func makeIterator() -> Iterator {
        return Iterator(_elements: SortedDictionary(self))
    }
    
    /// 
    public mutating func removeAll(keepCapacity: Bool = false) {
        keys.removeAll(keepCapacity: keepCapacity)
        values.removeAll(keepingCapacity: keepCapacity)
    }
    
}






