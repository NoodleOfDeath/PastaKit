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
open class NSSortedDictionary <Key: Comparable, Value> : NSObject, Collection, NSCoding {
    
    public typealias Index = Int
    public typealias Iterator = IndexingIterator<NSSortedDictionary<Key, Value>>
    
    open var startIndex: Index { return 0 }
    open var endIndex: Index { return values.count }
    open var count: Int { return values.count }
    
    /// 
    public typealias Element = (key: Key, value: Value)
    /// The order in which to sort array elements.
    open var sortOrder: SortOrder { return backingStorage.sortOrder }
    /// 
    open var keys: SortedArray<Key> { return backingStorage.keys }
    /// 
    open var values:[Value] { return backingStorage.values }
    
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
    
    open func encode(with aCoder: NSCoder) {
        aCoder.encode(sortOrder.rawValue, forKey: CodingKeys.SortOrder)
        aCoder.encode(keys, forKey: CodingKeys.Keys)
        aCoder.encode(values, forKey: CodingKeys.Values)
    }
    
    // MARK: - ** Subscript Methods **
    
    /// 
    open subscript (position: Index) -> Element {
        get { return backingStorage[position] }
        set { backingStorage[position] = newValue }
    }
    
    /// 
    open subscript (key: Key) -> Value? {
        get { return backingStorage[key] }
        set { backingStorage[key] = newValue }
    }
    
    open func makeIterator() -> Iterator {
        return Iterator(NSSortedDictionary(self))
    }
    
    /// 
    open func removeAll(keepCapacity: Bool = false) {
        backingStorage.removeAll(keepCapacity: keepCapacity)
    }
    
}



