//
//  QuickSortArray.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 6/23/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import Foundation

private struct CodingKeys {
    static let SortOrder = "SortOrder"
    static let Keys = "Keys"
    static let Values = "Values"
}

public class NSSortedDictionary <Key: Comparable, Value> : NSObject, CollectionType, NSCoding {
    
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
    
    public init(_ sortedDictionary: SortedDictionary<Key, Value>) {
        self.sortOrder = sortedDictionary.sortOrder
        self.keys = sortedDictionary.keys
        self.values = sortedDictionary.values
    }
    
    public convenience required init?(coder aDecoder: NSCoder) {
        guard let sortOrder = SortOrder(rawValue: aDecoder.decodeIntegerForKey(CodingKeys.SortOrder)) else { return nil }
        guard let keys = aDecoder.decodeObjectForKey(CodingKeys.Keys) as? SortedArray<Key> else { return nil }
        guard let values = aDecoder.decodeObjectForKey(CodingKeys.Values) as? [Value] else { return nil }
        self.init(sortOrder: sortOrder, keys: keys, values: values)
    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(sortOrder.rawValue, forKey: CodingKeys.SortOrder)
        aCoder.encodeObject(keys, forKey: CodingKeys.Keys)
        aCoder.encodeObject(values, forKey: CodingKeys.Values)
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
        return Generator(NSSortedDictionary(keys: keys, values: values))
    }
    
    public func removeAll() {
        keys.removeAll()
        values.removeAll()
    }
    
}



