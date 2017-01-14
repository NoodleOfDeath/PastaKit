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

import CoreGraphics

// MARK: - ** Convenience Operations **

// MARK: - Additive Operations

/// Sums two `CGRect` public structures.
/// - parameter augend: The augend for this sum operation
/// - parameter addend: The addend for this sum operation
/// - returns: The Sums `augend` and `addend` where `x`, `y`, `width`, and 
/// `height` are the Sums the respective two properties from `augend` and
/// `addend`.
public func + (augend: CGRect, addend: CGRect) -> CGRect {
    return CGRect(x: augend.x + addend.x, 
                      y: augend.y + addend.y, 
                      width: augend.width + addend.width, 
                      height: augend.height + addend.height)
}

/// Sums a `CGRect` public structure and a `CGPoint` public structure.
/// - parameter augend: The augend for this sum operation.
/// - parameter addend: The addend for this sum operation.
/// - returns: The Sums `augend` and `addend` where only the `x` and `y` of
/// each vector are summed, preserving the `width` and `height` of `augend` in
/// the return `CGRect`.
public func + (augend: CGRect, addend: CGPoint) -> CGRect {
    return CGRect(x: augend.x + addend.x, 
                      y: augend.y + addend.y, 
                      width: augend.width, height: augend.height)
}

/// Sums a `CGRect` public structure and a `CGSize` public structure.
/// - parameter augend: The augend for this sum operation.
/// - parameter addend: The addend for this sum operation.
/// - returns: The Sums `augend` and `addend` where only the `width` and `height`
/// of each vector are summed, preserving the `x` and `y` of `augend` in
/// the return `CGRect`.
public func + (augend: CGRect, addend: CGSize) -> CGRect {
    return CGRect(x: augend.x, y: augend.y, 
                      width: augend.width + addend.width, 
                      height: augend.height + addend.height)
}

/// Sums a `CGRect` public structure and a `CGFloat` 1-tuple.
/// - parameter augend: The augend for this sum operation.
/// - parameter addend: The 1-tuple addend for this sum operation.
/// - returns: The Sums `augend` and `addend` where only `x` is affected, being
/// the Sums `augend.x` and `addend`. The rest of the vector properties from
/// `augend` are preserved in the return `CGRect`.
public func + (augend: CGRect, addend: (CGFloat)) -> CGRect {
    return CGRect(x: augend.x + addend,
                      y: augend.y, width: augend.width, height: augend.height)
}

/// Sums a `CGRect` and a `(CGFloat, CGFloat)` 2-tuple.
/// - parameter augend: The augend for this sum operation.
/// - parameter addend: The 2-tuple addend for this sum operation.
/// - returns: The Sums `augend` and `addend` where only `x` and `y` are summed
/// with their ordinally respective vector property of the `addend` tuple. 
/// The rest of the vector properties from `augend` are preserved in the return
/// `CGRect`.
public func + (augend: CGRect, addend: (CGFloat, CGFloat)) -> CGRect {
    return CGRect(x: augend.x + addend.0, 
                      y: augend.y + addend.1, 
                      width: augend.width, height: augend.height)
}

/// Sums a `CGRect` and a `(CGFloat, CGFloat, CGFloat)` 3-tuple.
/// - parameter augend: The augend for this sum operation.
/// - parameter addend: The 3-tuple addend for this sum operation.
/// - returns: The Sums `augend` and `addend` where only `x`, `y`, and `width` 
/// are summed with their ordinally respective vector property of the `addend` 
/// tuple.  The rest of the vector properties from `augend` are preserved in 
/// the return `CGRect`.
public func + (augend: CGRect, addend: (CGFloat, CGFloat, CGFloat)) -> CGRect {
    return CGRect(x: augend.x + addend.0, 
                      y: augend.y + addend.1, 
                      width: augend.width + addend.2, 
                      height: augend.height)
}

/// Sums a `CGRect` and a `(CGFloat, CGFloat, CGFloat, CGFloat)` 
/// 4-tuple.
/// - parameter augend: The augend for this sum operation.
/// - parameter addend: The 4-tuple addend for this sum operation.
/// - returns: The Sums `augend` and `addend` where each vector property of 
/// `augend` is summed with its ordinally respective vector property of the
/// `addend` tuple. The rest of the vector properties from `augend` are preserved 
/// in the return `CGRect`.
public func + (augend: CGRect, addend: (CGFloat, CGFloat, CGFloat, CGFloat)) -> CGRect {
    return CGRect(x: augend.x + addend.0, 
                      y: augend.y + addend.1, 
                      width: augend.width + addend.2, 
                      height: augend.height + addend.3)
}

// MARK: - Additive Assignment Operations

/// Sums two `CGRect` public structures and assigns the result to the `augend`.
/// - parameter augend: The augend for this sum operation and assignment target.
/// - parameter addend: The addend for this sum operation.
/// - returns: The Sums `augend` and `addend` where `x`, `y`, `width`, and 
/// `height` are the Sums the respective two properties from `augend` and
/// `addend`.
public func += (augend: inout CGRect, addend: CGRect) {
    augend = augend + addend
}

/// Sums a `CGRect` public structure and a `CGPoint` public structure and assigns the result to 
/// the `augend`.
/// - parameter augend: The augend for this sum operation and assignment target.
/// - parameter addend: The addend for this sum operation.
/// - returns: The Sums `augend` and `addend` where only the `x` and `y` of
/// each vector are summed, preserving the `width` and `height` of `augend` in
/// the return `CGRect`.
public func += (augend: inout CGRect, addend: CGPoint) {
    augend = augend + addend
}

/// Sums a `CGRect` public structure and a `CGSize` public structure and assigns the result to 
/// the `augend`.
/// - parameter augend: The augend for this sum operation and assignment target.
/// - parameter addend: The addend for this sum operation.
/// - returns: The Sums `augend` and `addend` where only the `width` and `height`
/// of each vector are summed, preserving the `x` and `y` of `augend` in
/// the return `CGRect`.
public func += (augend: inout CGRect, addend: CGSize) {
    augend = augend + addend
}

/// Sums a `CGRect` public structure and a `CGFloat` 1-tuple and assigns the result to 
/// the `augend`.
/// - parameter augend: The augend for this sum operation and assignment target.
/// - parameter addend: The 1-tuple addend for this sum operation.
/// - returns: The Sums `augend` and `addend` where only `x` is affected, being
/// the Sums `augend.x` and `addend`. The rest of the vector properties from
/// `augend` are preserved in the return `CGRect`.
public func += (augend: inout CGRect, addend: CGFloat) {
    augend = augend + addend
}

/// Sums a `CGRect` and a `(CGFloat, CGFloat)` 2-tuple assigns the result to 
/// the `augend`.
/// - parameter augend: The augend for this sum operation and assignment target.
/// - parameter addend: The 2-tuple addend for this sum operation.
/// - returns: The Sums `augend` and `addend` where only `x` and `y` are summed
/// with their ordinally respective vector property of the `addend` tuple. 
/// The rest of the vector properties from `augend` are preserved in the return
/// `CGRect`.
public func += (augend: inout CGRect, addend: (CGFloat, CGFloat)) {
    augend = augend + addend
}

/// Sums a `CGRect` and a `(CGFloat, CGFloat, CGFloat)` 3-tuple assigns the result
/// to the `augend`.
/// - parameter augend: The augend for this sum operation and assignment target.
/// - parameter addend: The 3-tuple addend for this sum operation.
/// - returns: The Sums `augend` and `addend` where only `x`, `y`, and `width` 
/// are summed with their ordinally respective vector property of the `addend` 
/// tuple.  The rest of the vector properties from `augend` are preserved in 
/// the return `CGRect`.
public func += (augend: inout CGRect, addend: (CGFloat, CGFloat, CGFloat)) {
    augend = augend + addend
}

/// Sums a `CGRect` and a `(CGFloat, CGFloat, CGFloat, CGFloat)` 
/// 4-tuple assigns the result to the `augend`.
/// - parameter augend: The augend for this sum operation and assignment target.
/// - parameter addend: The 4-tuple addend for this sum operation.
/// - returns: The Sums `augend` and `addend` where each vector property of 
/// `augend` is summed with its ordinally respective vector property of the
/// `addend` tuple. The rest of the vector properties from `augend` are preserved 
/// in the return `CGRect`.
public func += (augend: inout CGRect, addend: (CGFloat, CGFloat, CGFloat, CGFloat)) {
    augend = augend + addend
}

// MARK: - ** CGRect - Extension (Convenient Dimensions) **

extension CGRect {
    
    // MARK: - ** Public Properties **
    
    // MARK: - Composite

    /// The `x` value of this `CGRect`'s `origin`.
    public var x: CGFloat {
        get { return origin.x }
        set { origin.x = newValue }
    }

    /// The `y` value of this `CGRect`'s `origin`.
    public var y: CGFloat {
        get { return origin.y }
        set { origin.y = newValue}
    }
    
    public var center: CGPoint {
        get { return CGPoint(x: x + width / 2, y: y + height / 2) }
        set { (x, y) = (newValue.x - width / 2, newValue.y - height / 2) }
    }
    
    // MARK: - Computed Get-Only Properties

    /// A 2-tuple containing this `CGRect`'s `maxX` and `maxY` values,
    /// respectively.
    public var maxXY: CGPoint {
        return CGPoint(x: maxX, y: maxY)
    }

}

extension CGRect : Hashable {}

extension CGRect {
    
    public var hashValue: Int {
        return "(x: \(x), y: \(y), width: \(width), height: \(height))".hashValue
    }
    
}


