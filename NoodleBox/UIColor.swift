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

public let NSColorCode = "NSColorCode"
public let NSAlpha = "NSAlpha"

public func * (lhs: UIColor, rhs: CGFloat) -> UIColor {
    return lhs.withAlphaComponent(rhs)
}

public func * (lhs: UIColor, rhs: Double) -> UIColor {
    return lhs.withAlphaComponent(rhs.asCGFloat)
}

extension UIColor {

    ///    The six-digit hexadecimal representation of color of the form #RRGGBB.
    /// - parameter hex6: Six-digit hexadecimal value.
    public convenience init(hex6: UInt, alpha: CGFloat = 1.0) {
        let divisor = CGFloat(255.0)
        let red     = CGFloat((hex6 & 0xFF0000) >> 16) / divisor
        let green   = CGFloat((hex6 & 0x00FF00) >>  8) / divisor
        let blue    = CGFloat( hex6 & 0x0000FF       ) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    ///    The six-digit hexadecimal representation of color with alpha of the form #RRGGBBAA.
/// - parameter hex8: Eight-digit hexadecimal value.
    public convenience init(hex8: UInt) {
        let divisor = CGFloat(255.0)
        let red     = CGFloat((hex8 & 0xFF000000) >> 24) / divisor
        let green   = CGFloat((hex8 & 0x00FF0000) >> 16) / divisor
        let blue    = CGFloat((hex8 & 0x0000FF00) >>  8) / divisor
        let alpha   = CGFloat( hex8 & 0x000000FF       ) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    open static func colorWith(_ any: Any?) -> UIColor? {

        guard let any = any else { return nil }
        
        func parseColorCode(_ code: Any?) -> UInt? {
            
            guard let code = code else { return nil }
            
            switch code {
                
            case let code as UInt:
                return code
                
            case let code as String:
                return UInt(code)
                
            default:
                return nil
                
            }
            
        }

        switch any {
            
        case let dict as [String : Any]:
            guard let hexcode = parseColorCode(dict[NSColorCode]) else { return nil }
            let alpha = dict[NSAlpha] as? CGFloat ?? 1.0
            return UIColor(hex6: hexcode, alpha: alpha)
            
        default:
            break
            
        }
        
        return nil

    }

}
