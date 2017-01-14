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

// MARK: - ** Convenicence CGPoint Construction from 2-tuple **

public postfix func * (argument: (x: Int, y: Int)) -> CGPoint {
    return CGPoint(x: CGFloat(argument.x), y: CGFloat(argument.y))
}

// MARK: - ** Public Operations **

// MARK: - Additive Operations

public func - (lhs: (x: CGFloat, y: CGFloat), rhs: (x: CGFloat, y: CGFloat)) -> CGPoint {
    return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

public func + (lhs: (x: CGFloat, y: CGFloat), x: CGFloat) -> CGPoint {
    return CGPoint(x: lhs.x + x, y: lhs.y)
}

public func - (lhs: (x: CGFloat, y: CGFloat), x: CGFloat) -> CGPoint {
    return CGPoint(x: lhs.x - x, y: lhs.y)
}

public func + (lhs: CGPoint, rhs: (x: CGFloat, y: CGFloat)) -> CGPoint {
    return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

public func - (lhs: CGPoint, rhs: (x: CGFloat, y: CGFloat)) -> CGPoint {
    return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

public func + (lhs: (x: CGFloat, y: CGFloat), rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

public func - (lhs: (x: CGFloat, y: CGFloat), rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

public func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

public func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

public func + (lhs: CGPoint, x: CGFloat) -> CGPoint {
    return CGPoint(x: lhs.x + x, y: lhs.y)
}

public func - (lhs: CGPoint, x: CGFloat) -> CGPoint {
    return CGPoint(x: lhs.x - x, y: lhs.y)
}

// MARK: - ** Additive Assignment Operations **

public func += (lhs: inout CGPoint, rhs: CGPoint) {
    lhs = lhs + rhs
}

public func -= (lhs: inout CGPoint, rhs: CGPoint) {
    lhs = lhs - rhs
}

extension CGPoint : Hashable {}

extension CGPoint {
    
    public var hashValue: Int {
        return "(x: \(x), y: \(y))".hashValue
    }
    
    public var transposed: CGPoint {
        return CGPoint(x: y, y: x)
    }
    
}
