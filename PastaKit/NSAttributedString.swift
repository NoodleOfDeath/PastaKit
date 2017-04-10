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

/// Convenience get-only properties and methods for the
/// `NSAttributedString` open class.
extension NSAttributedString {
    
    /// The range representation of this string.
    /// - returns: `NSMakeRange(0, length)`
    open var range: NSRange {
        return NSMakeRange(0, length)
    }
    
    /// The width of the leading whitespaces that offset this string.
    open var leadingIndentation: CGFloat {
        return attributedSubstring(from: NSMakeRange(0, string.leadingWhitespaces.length)).size().width
    }
    
    /// The width this string would attain is the drawing bounds were constrainted
    /// to a maximum height.
    /// - parameter height: The maximum height to constrain the drawing bounds in.
    /// - returns: The width this string would attain is the drawing bounds were
    /// constrainted to a maximum height of `height`.
    open func width(whenConstrainedToHeight height: CGFloat = .greatestFiniteMagnitude) -> CGFloat {
        let size = CGSize(width: .greatestFiniteMagnitude, height: height)
        let rect = boundingRect(with: size, options: .usesLineFragmentOrigin, context: nil)
        return ceil(rect.size.width)
    }
    
    /// The height this string would attain is the drawing bounds were constrainted
    /// to a maximum width.
    /// - parameter width: The maximum width to constrain the drawing bounds in.
    /// - returns: The height this string would attain is the drawing bounds were
    /// constrainted to a maximum width of `width`.
    open func height(whenConstrainedToWidth width: CGFloat = .greatestFiniteMagnitude) -> CGFloat {
        let size = CGSize(width: width, height: .greatestFiniteMagnitude)
        let rect = boundingRect(with: size, options: .usesLineFragmentOrigin, context: nil)
        return ceil(rect.height)
    }
    
}

