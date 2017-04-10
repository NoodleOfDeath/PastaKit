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

///
public func + <Element>(lhs: [Element]?, rhs: [Element]) -> [Element] {
    return (lhs ?? []) + rhs
}

///
public func + <Element>(lhs: [Element], rhs: [Element]?) -> [Element] {
    return lhs + (rhs ?? [])
}

///
public func + <Element>(lhs: [Element]?, rhs: [Element]?) -> [Element]? {
    if let lhs = lhs {
        return (lhs + rhs) as [Element]
    }
    if let rhs = rhs {
        return (lhs + rhs) as [Element]
    }
    return nil
}

///
public postfix func * <Element: Any>(argument: [Element]) -> NSArray {
    return argument as NSArray
}

///
public postfix func * <Element: Any>(argument: [Element]?) -> NSArray? {
    return argument as NSArray?
}

extension Array {
    
    /// The range representation of this array.
    public var range: NSRange {
        return NSMakeRange(0, count - 1)
    }
    
}

extension Array {
    
    /// Returns whether or not the specified index is within the index
    /// bounds of this array.
    /// - parameter index: an index
    /// - returns: `true` if `index` is within the bounds of this array.
    /// `false` otherwise.
    public func contains(index: Int) -> Bool {
        return index >= 0 && index < count
    }
    
}

extension Array {
    
    /// Alias of `removeFirst()`
    public mutating func pop() -> Element? {
        return removeFirst()
    }
    
    /// Conditional alias of `append(element: Element)`.
    /// - parameter element: 
    /// - complexity: Amortized O(1) unless self's storage is shared with another 
    /// live array; O(count) if self does not wrap a bridged NSArray; 
    /// otherwise the efficiency is unspecified..
    public mutating func append(_ element: Element?) {
        guard let element = element else { return }
        append(element)
    }
    
    /// Alias of `append(element: Element)` with variable arity parameters.
    /// - complexity: Amortized O(n) unless self's storage is shared with another 
    /// live array; O(count) if self does not wrap a bridged NSArray; 
    /// otherwise the efficiency is unspecified. `n` is the number of elements
    /// being appeneded.
    public mutating func append(_ element: Element, _ anotherElement: Element, _ elements: Element...) {
        append(element)
        append(anotherElement)
        for element in elements { append(element) }
    }
    
    /// Pushes an element onto the stack, at index 0.
    public mutating func push(_ element: Element?) {
        guard let element = element else { return }
        insert(element, at: 0)
    }
    
    /// Pushes elements onto the stack, at index 0, in FIFO fashion.
    /// - parameter elements: The elements to push onto the stack.
    public mutating func push(_ elements: [Element]) {
        for element in elements { push(element) }
    }
    
    /// Pushes elements onto the stack, at index 0, in FIFO fashion.
    public mutating func push(_ element: Element, _ anotherElement: Element, _ elements: Element...) {
        push(element)
        push(anotherElement)
        push(elements)
    }
    
}

extension Array where Element : Equatable {

    /// Appends an `element` to `self` iff `element` is not already
    /// contained in `self`.
    /// - parameter element: An `element` to append to `self`.
    public mutating func appendUnique(_ elements: Element...) {
        for element in elements where !contains(element) {
            append(element)
        }
    }
    
    /// 
    public mutating func appendUnique(_ elements: [Element]) {
        for element in elements { appendUnique(element) }
    }
    
    /// Removes _all_ instances of `element` from `self`.
    /// - parameter element: The `element` to remove from `self.
    /// - returns: The number of occurrences of `element` that were removed
    /// form self.
    public mutating func remove(_ element: Element) -> Int {
        var occurrences = 0
        for index in (0 ..< count).reversed() {
            guard self[index] == element else { continue }
            self.remove(at: index)
            occurrences += 1
        }
        return occurrences
    }
    
}

