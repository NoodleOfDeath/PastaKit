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

/// 
public class NSSortedDictionary <Key: Comparable, Value> : NSObject, Collection, NSCoding {
    
    /// Returns the position immediately after the given index.
    ///
    /// - Parameter i: A valid index of the collection. `i` must be less than
    ///   `endIndex`.
    /// - Returns: The index value immediately after `i`.
    public func index(after i: Int) -> Int {
        return i + 1
    }

    
    public typealias Index = Int
    public typealias Iterator = IndexingIterator<NSSortedDictionary<Key, Value>>
    
    public var startIndex: Index { return 0 }
    public var endIndex: Index { return values.count }
    public var count: Int { return values.count }
    
    /// 
    public typealias Element = (key: Key, value: Value)
    /// The order in which to sort array elements.
    public var sortOrder: SortOrder { return backingStorage.sortOrder }
    /// 
    public var keys: SortedArray<Key> { return backingStorage.keys }
    /// 
    public var values:[Value] { return backingStorage.values }
    
    /// 
    fileprivate var backingStorage: SortedDictionary<Key, Value>
    
    // MARK: - ** Constructor Methods **
    
    /// 
    public init(sortOrder: SortOrder = .ascending, keys: SortedArray<Key>? = nil, values: [Value] = []) {
        backingStorage = SortedDictionary<Key, Value>(sortOrder: sortOrder, keys: keys, values: values)
    }
    
    /// 
    public init(_ sortedDictionary: SortedDictionary<Key, Value>) {
        backingStorage = sortedDictionary
    }
    
    /// 
    public init(_ sortedDictionary: NSSortedDictionary<Key, Value>) {
        backingStorage = sortedDictionary.backingStorage
    }
    
    public convenience required init?(coder aDecoder: NSCoder) {
        guard let sortOrder = SortOrder(rawValue: aDecoder.decodeInteger(forKey: CodingKeys.SortOrder)) else { return nil }
        guard let keys = aDecoder.decodeObject(forKey: CodingKeys.Keys) as? SortedArray<Key> else { return nil }
        guard let values = aDecoder.decodeObject(forKey: CodingKeys.Values) as? [Value] else { return nil }
        self.init(sortOrder: sortOrder, keys: keys, values: values)
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(sortOrder.rawValue, forKey: CodingKeys.SortOrder)
        aCoder.encode(keys, forKey: CodingKeys.Keys)
        aCoder.encode(values, forKey: CodingKeys.Values)
    }
    
    // MARK: - ** Subscript Methods **
    
    /// 
    public subscript (position: Index) -> Element {
        get { return backingStorage[position] }
        set { backingStorage[position] = newValue }
    }
    
    /// 
    public subscript (key: Key) -> Value? {
        get { return backingStorage[key] }
        set { backingStorage[key] = newValue }
    }
    
    /// 
    public func makeIterator() -> Iterator {
        return Iterator(_elements: NSSortedDictionary(self))
    }
    
    /// 
    public func removeAll(keepCapacity: Bool = false) {
        backingStorage.removeAll(keepCapacity: keepCapacity)
    }
    
}



