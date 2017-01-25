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

// MARK: - NSParagraphStyle Extension
extension NSParagraphStyle {

    /// Provide a preset [NSMutableParagraphStyle](xdoc://) instance with a specific tab span
    /// - parameter tabSpan: Character width of tab characters (default is 4)
    /// - parameter attrs: The contextual font attributes for which to determine character width
    /// - parameter strReference: Character used to determine a single character width
    /// - returns: A [NSMutableParagraphStyle](xdoc://) instance with a tab span of `tabSpan` based on font with attributes `attrs`
    open static func mutableStyle(_ tabWidth: Int = 4, attributes attrs: [String: Any] = [NSFontAttributeName: UIFont.systemFont()], strReference: String = "A") -> NSMutableParagraphStyle {
        let paragraphStyle = `default`.mutableCopy() as! NSMutableParagraphStyle
        let charWidth = strReference.width(withAttributes: attrs)
        paragraphStyle.defaultTabInterval = charWidth * CGFloat(tabWidth)
        paragraphStyle.tabStops = nil
        return paragraphStyle
    }

}
