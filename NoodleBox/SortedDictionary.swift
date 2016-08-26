//
//  SortedDictionary.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 8/15/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation

public struct SortedDictionary <Key: Comparable, Value> : CollectionType, _ObjectiveCBridgeable {
    
    public typealias _ObjectiveCType = NSSortedDictionary<Key, Value>
    
    public typealias Element = (key: Key, value: Value)
    public typealias Index = Int
    public typealias Generator = IndexingGenerator<NSSortedDictionary<Key, Value>>
    
    public var startIndex: Index {
        return 0
    }
    
    public var endIndex: Index {
        return values.count
    }
    
    public let sortOrder: SortOrder
    public private (set) var keys = SortedArray<Key>()
    public private (set) var values = [Value]()
    
    public var count: Int {
        return values.count
    }
    
    // MARK: - ** Constructor Methods **
    
    public init(sortOrder: SortOrder = .Ascending, keys: SortedArray<Key>? = nil, values: [Value]? = nil) {
        self.sortOrder = sortOrder
        self.keys = keys ?? SortedArray<Key>(sortOrder: sortOrder)
        self.values = values ?? [Value]()
    }
    
    public init(_ sortedDictionary: NSSortedDictionary<Key, Value>) {
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
    
    public static func _forceBridgeFromObjectiveC(source: _ObjectiveCType, inout result: SortedDictionary<Key, Value>?) {
        result = SortedDictionary<Key, Value>(source)
    }
    
    public static func _conditionallyBridgeFromObjectiveC(source: _ObjectiveCType, inout result: SortedDictionary<Key, Value>?) -> Bool {
        _forceBridgeFromObjectiveC(source, result: &result)
        return true
    }
    
    public func _bridgeToObjectiveC() -> _ObjectiveCType {
        return NSSortedDictionary<Key, Value>(self)
    }
    
    // MARK: - ** Subscript Methods **
    
    public subscript (position: Index) -> Element {
        get { return (keys[position], values[position]) }
        set { (keys[position], values[position]) = newValue }
    }
    
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
                    keys.removeAtIndex(index)
                    values.removeAtIndex(index)
                }
            } else {
                if let newValue = newValue {
                    if let index = keys.add(key) {
                        values.insert(newValue, atIndex: index)
                    }
                }
            }
        }
    }
    
    public func generate() -> Generator {
        return Generator(NSSortedDictionary(values: values))
    }
    
    public mutating func removeAll() {
        keys.removeAll()
        values.removeAll()
    }
    
}






