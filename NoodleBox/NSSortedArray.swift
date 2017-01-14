// Copyright (c) 2016 NoodleNation <noodlebox@noodlenation.net>
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

fileprivate struct CodingKeys {
    static let SortOrder = "SortOrder"
    static let Elements = "Elements"
    static let Surjective = "Surjective"
}

// MARK: - ** NSSortedArray Class **

/// An array class that automatically places elements in order as
/// they added to the collection.
public class NSSortedArray <Element: Comparable> : NSObject, Collection, NSCoding {

    // MARK: - CollectionType
    
    public typealias BackingStorage = SortedArray<Element>
    public typealias Index = BackingStorage.Index
    public typealias Iterator = IndexingIterator<NSSortedArray<Element>>
    
    public var startIndex: Index { return 0 }
    public var endIndex: Index { return elements.count }
    public var range: CountableRange<Index> { return 0 ..< elements.count }
    public var count: Int { return elements.count }
    
    // MARK: - CustomStringConvertible
    
    public override var description: String { return "\(elements)" }
    
    // MARK: - NSSortedArray
    
    /// The elements of this array.
    public var elements: [Element] { return backingStorage.elements }
    /// The order in which to sort array elements.
    public var sortOrder: SortOrder { return backingStorage.sortOrder }
    /// Whether or not this set is surjective.
    public var surjective: Bool { return backingStorage.surjective }
    
    /// 
    fileprivate var backingStorage: BackingStorage
    
    // MARK: - ** Constructor Methods **
    
    // MARK: - NSSortedArray
    
    /// Verbose constructor in which the sort order can be established at
    /// initialization.
    /// - parameter sortOrder: The order in which to sort array elements.
    /// - parameter elements: The initial elements to populate this array.
    /// - note: The initial elements parameter need not be sorted, as it will
    /// automatically be sorted upon initialization.
    /// - returns: An array structure instance with sorted elements.
    public init(elements: [Element] = [Element](), sortOrder: SortOrder = .ascending, surjective: Bool = false) {
        backingStorage = BackingStorage(elements: elements, sortOrder: sortOrder, surjective: surjective)
    }
    
    /// Duplication constructor.
    /// - parameter sortedArray: Another array to initialize from.
    /// - returns: An array structure instance with sorted elements
    /// identical to `sortedArray`.
    public init(_ sortedArray: NSSortedArray<Element>) {
        backingStorage = sortedArray.backingStorage
    }
    
    /// Bridging constructor from a `SortedArray` structure instance.
    /// - parameter sortedArray: Another array to initialize from.
    /// - returns: An array class instance with sorted elements
    /// identical to `sortedArray`.
    public init(_ sortedArray: BackingStorage) {
        backingStorage = sortedArray
    }
    
    // MARK: - NSCoding
    
    public convenience required init?(coder aDecoder: NSCoder) {
        guard let elements = aDecoder.decodeObject(forKey: CodingKeys.Elements) as? [Element],
            let sortOrder = SortOrder(rawValue: aDecoder.decodeInteger(forKey: CodingKeys.SortOrder)) else { return nil }
        let surjective = aDecoder.decodeBool(forKey: CodingKeys.Surjective)
        self.init(elements: elements, sortOrder: sortOrder, surjective: surjective)
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(elements, forKey: CodingKeys.Elements)
        aCoder.encode(sortOrder.rawValue, forKey: CodingKeys.SortOrder)
        aCoder.encode(surjective, forKey: CodingKeys.Surjective)
    }
    
    // MARK: - CollectionType
    
    public subscript (index: Index) -> Element {
        get { return backingStorage[index] }
        set { backingStorage[index] = newValue }
    }

    public func index(after i: Int) -> Int {
        return backingStorage.index(after: i)
    }
    
    public func makeIterator() -> Iterator {
        return Iterator(_elements: NSSortedArray<Element>(self))
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
    public func add(_ element: Element, offset: Int = 0) -> Index? {
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
