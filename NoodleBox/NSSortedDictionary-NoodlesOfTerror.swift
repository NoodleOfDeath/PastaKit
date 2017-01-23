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

    public typealias BackingStorage = SortedDictionary<Key, Value>
    public typealias Index = Int
    public typealias Iterator = IndexingIterator<NSSortedDictionary<Key, Value>>
    
    public var startIndex: Index { return 0 }
    public var endIndex: Index { return values.count }
    public var count: Int { return values.count }
    
    /// 
    public typealias Element = (key: Key, value: Value)
    
    /// 
    public var keys: SortedArray<Key> { return backingStorage.keys }
    /// 
    public var values:[Value] { return backingStorage.values }
    /// The order in which to sort array elements.
    public var sortOrder: SortOrder { return backingStorage.sortOrder }
    
    /// 
    fileprivate var backingStorage: BackingStorage
    
    // MARK: - ** Constructor Methods **
    
    /// 
    public init(keys: SortedArray<Key>? = nil, values: [Value] = [], sortOrder: SortOrder = .ascending) {
        backingStorage = BackingStorage(keys: keys, values: values, sortOrder: sortOrder)
    }
    
    /// 
    public init(_ sortedDictionary: NSSortedDictionary<Key, Value>) {
        backingStorage = sortedDictionary.backingStorage
    }
    
    /// 
    public init(_ sortedDictionary: BackingStorage) {
        backingStorage = sortedDictionary
    }
    
    public convenience required init?(coder aDecoder: NSCoder) {
        guard let sortOrder = SortOrder(rawValue: aDecoder.decodeInteger(forKey: CodingKeys.SortOrder)) else { return nil }
        guard let keys = aDecoder.decodeObject(forKey: CodingKeys.Keys) as? SortedArray<Key> else { return nil }
        guard let values = aDecoder.decodeObject(forKey: CodingKeys.Values) as? [Value] else { return nil }
        self.init(keys: keys, values: values, sortOrder: sortOrder)
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(sortOrder.rawValue, forKey: CodingKeys.SortOrder)
        aCoder.encode(keys, forKey: CodingKeys.Keys)
        aCoder.encode(values, forKey: CodingKeys.Values)
    }
    
    /// 
    public func makeIterator() -> Iterator {
        return Iterator(_elements: NSSortedDictionary<Key, Value>(self))
    }
    
    /// 
    public func removeAll(keepCapacity: Bool = false) {
        backingStorage.removeAll(keepCapacity: keepCapacity)
    }
    
    /// Returns the position immediately after the given index.
    ///
    /// - Parameter i: A valid index of the collection. `i` must be less than
    ///   `endIndex`.
    /// - Returns: The index value immediately after `i`.
    public func index(after i: Int) -> Int {
        return backingStorage.index(after: i)
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
    
}



