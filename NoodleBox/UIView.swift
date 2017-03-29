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

extension UIView {
    
    /// Origin of the frame of this view.
    open var origin: CGPoint {
        get { return frame.origin }
        set { frame.origin = newValue }
    }
    
    /// Size of the frame of this view.
    open var size: CGSize {
        get { return frame.size }
        set { frame.size = newValue }
    }
    
    /// x-coordinate of the frame of this view.
    open var x: CGFloat {
        get { return frame.x }
        set { frame.x = newValue }
    }
    
    /// y-coordinate of the frame of this view.
    open var y: CGFloat {
        get { return frame.y }
        set { frame.y = newValue }
    }
    
    /// Width of the frame of this view.
    open var width: CGFloat {
        get { return frame.size.width }
        set { frame.size = CGSize(width: newValue, height: height) }
    }
    
    /// Height of the frame of this view.
    open var height: CGFloat {
        get { return frame.height }
        set { frame.size = CGSize(width: width, height: newValue) }
    }
    
}

