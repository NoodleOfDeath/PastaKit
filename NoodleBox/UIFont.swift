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

public let CTFontFamily = "CTFontFamily"
public let CTFontSize = "CTFontSize"

// MARK: - UIFont Extension

extension UIFont {

    /// Returns the font object used for standard interface items in the size of the standard system font.
    /// A font object of the standard system font and size.
    /// - returns: A font object of the standard system font and size.
    open static func systemFont() -> UIFont {
        return self.systemFont(ofSize: systemFontSize)
    }

    /// 
    open static func fontWith(_ any: Any, size: CGFloat = UIFont.systemFontSize) -> UIFont? {
        
        switch any {
            
        case let any as UIFont:
            return any
            
        case let any as [String : Any]:
            guard let family = any[CTFontFamily] as? String else { return nil }
            let size = any[CTFontSize] as? CGFloat ?? size
            return UIFont(name: family, size: size)
            
        default:
            break
            
        }
        
        return nil
        
    }

}
