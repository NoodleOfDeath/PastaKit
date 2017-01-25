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
/// `lhs =< rhs` means if `rhs` is less than `lhs`, assign `rhs` to `lhs`
/// - parameter lhs: The value to be updated
/// - parameter rhs: The value to assign to `lhs` if it is less than `lhs`
///
public func =< <T: Comparable>(lhs: inout T, rhs: T) {
    lhs = (lhs < rhs ? lhs : rhs)
}

///
/// `lhs => rhs` means if `rhs` is greater than `lhs`, assign `rhs` to `lhs`
/// - parameter lhs: The value to be updated
/// - parameter rhs: The value to assign to `lhs` if it is greater than `lhs`
///
public func => <T: Comparable>(lhs: inout T, rhs: T) {
    lhs = (lhs > rhs ? lhs : rhs)
}

/// Modulo division the way it is supposed to be
public func %% <T: SignedInteger>(lhs: T, rhs: T) -> T {
    var lhs = lhs
    if lhs < 0 {
        lhs = rhs - abs(lhs)
    }
    return lhs % rhs
}

extension UInt {
    
    public init?(_ text: String) {
        
        let hexPrefix = text.range(of: "0x") ?? text.range(of: "#")
        
        var text = text
        var radix = 10
        
        switch text {
            
        case _ where hexPrefix?.lowerBound == text.startIndex:
            text.replaceSubrange(hexPrefix!, with: "")
            radix = 16
            break
            
        default:
            break
            
        }
        
        self.init(text, radix: radix)
    
    }

}

// MARK: - Int Extension
extension Int {
    
    public var inverse: Double {
        return 1 / Double(self)
    }
    
    public var asInt: Int {
        return Int(self)
    }
    
    public var asUInt: UInt {
        return UInt(self)
    }
    
    public var asInt32: Int32 {
        return Int32(self)
    }
    
    public var asUInt32: UInt32 {
        return UInt32(self)
    }
    
    public var asInt64: Int64 {
        return Int64(self)
    }
    
    public var asUInt64: UInt64 {
        return UInt64(self)
    }
    
    public var asDouble: Double {
        return Double(self)
    }
    
    public var asFloat: Float {
        return Float(self)
    }
    
    public var asCGFloat: CGFloat {
        return CGFloat(self)
    }
    
    public var asDataSizeString: String {
        return asDataSizeString()
    }
    
    public func format(_ format: String = "") -> String {
        return String(format: "%\(format)d", self)
    }
    
    public func asDataSizeString(withFormattingOptions options: NSDataSizeFormattingOption = .Default) -> String {
        return asUInt64.asDataSizeString(withFormattingOptions: options)
    }
    
}

extension UInt {
    
    public var asInt: Int {
        return Int(self)
    }
    
    public var asUInt: UInt {
        return UInt(self)
    }
    
    public var asInt32: Int32 {
        return Int32(self)
    }
    
    public var asUInt32: UInt32 {
        return UInt32(self)
    }
    
    public var asInt64: Int64 {
        return Int64(self)
    }
    
    public var asUInt64: UInt64 {
        return UInt64(self)
    }
    
    public var asDouble: Double {
        return Double(self)
    }
    
    public var asFloat: Float {
        return Float(self)
    }
    
    public var asCGFloat: CGFloat {
        return CGFloat(self)
    }
    
    public var asDataSizeString: String {
        return asDataSizeString()
    }
    
    public func format(_ format: String = "") -> String {
        return String(format: "%\(format)ud", self)
    }
    
    public func asDataSizeString(withFormattingOptions options: NSDataSizeFormattingOption = .Default) -> String {
        return asUInt64.asDataSizeString(withFormattingOptions: options)
    }
    
}

extension Int32 {
    
    public var asInt: Int {
        return Int(self)
    }
    
    public var asUInt: UInt {
        return UInt(self)
    }
    
    public var asInt32: Int32 {
        return Int32(self)
    }
    
    public var asUInt32: UInt32 {
        return UInt32(self)
    }
    
    public var asInt64: Int64 {
        return Int64(self)
    }
    
    public var asUInt64: UInt64 {
        return UInt64(self)
    }
    
    public var asDouble: Double {
        return Double(self)
    }
    
    public var asFloat: Float {
        return Float(self)
    }
    
    public var asCGFloat: CGFloat {
        return CGFloat(self)
    }
    
    public var asDataSizeString: String {
        return asDataSizeString()
    }
    
    public func format(_ format: String = "") -> String {
        return String(format: "%\(format)d", self)
    }
    
    public func asDataSizeString(withFormattingOptions options: NSDataSizeFormattingOption = .Default) -> String {
        return asUInt64.asDataSizeString(withFormattingOptions: options)
    }
    
}

extension UInt32 {
    
    public var asInt: Int {
        return Int(self)
    }
    
    public var asUInt: UInt {
        return UInt(self)
    }
    
    public var asInt32: Int32 {
        return Int32(self)
    }
    
    public var asUInt32: UInt32 {
        return UInt32(self)
    }
    
    public var asInt64: Int64 {
        return Int64(self)
    }
    
    public var asUInt64: UInt64 {
        return UInt64(self)
    }
    
    public var asDouble: Double {
        return Double(self)
    }
    
    public var asFloat: Float {
        return Float(self)
    }
    
    public var asCGFloat: CGFloat {
        return CGFloat(self)
    }
    
    public var asDataSizeString: String {
        return asDataSizeString()
    }
    
    public func format(_ format: String = "") -> String {
        return String(format: "%\(format)ud", self)
    }
    
    public func asDataSizeString(withFormattingOptions options: NSDataSizeFormattingOption = .Default) -> String {
        return asUInt64.asDataSizeString(withFormattingOptions: options)
    }
    
}

extension Int64 {
    
    public var asInt: Int {
        return Int(self)
    }
    
    public var asUInt: UInt {
        return UInt(self)
    }
    
    public var asInt32: Int32 {
        return Int32(self)
    }
    
    public var asUInt32: UInt32 {
        return UInt32(self)
    }
    
    public var asInt64: Int64 {
        return Int64(self)
    }
    
    public var asUInt64: UInt64 {
        return UInt64(self)
    }
    
    public var asDouble: Double {
        return Double(self)
    }
    
    public var asFloat: Float {
        return Float(self)
    }
    
    public var asCGFloat: CGFloat {
        return CGFloat(self)
    }
    
    public var asDataSizeString: String {
        return asDataSizeString()
    }
    
    public func format(_ format: String = "") -> String {
        return String(format: "%\(format)d", self)
    }
    
    public func asDataSizeString(withFormattingOptions options: NSDataSizeFormattingOption = .Default) -> String {
        return asUInt64.asDataSizeString(withFormattingOptions: options)
    }
    
}

extension UInt64 {
    
    public var asInt: Int {
        return Int(self)
    }
    
    public var asUInt: UInt {
        return UInt(self)
    }
    
    public var asInt32: Int32 {
        return Int32(self)
    }
    
    public var asUInt32: UInt32 {
        return UInt32(self)
    }
    
    public var asInt64: Int64 {
        return Int64(self)
    }
    
    public var asUInt64: UInt64 {
        return UInt64(self)
    }
    
    public var asDouble: Double {
        return Double(self)
    }
    
    public var asFloat: Float {
        return Float(self)
    }
    
    public var asCGFloat: CGFloat {
        return CGFloat(self)
    }
    
    public var asDataSizeString: String {
        return asDataSizeString()
    }
    
    public func format(_ format: String = "") -> String {
        return String(format: "%\(format)ud", self)
    }
    
    public func asDataSizeString(withFormattingOptions options: NSDataSizeFormattingOption = .Default) -> String {
        return NSDataSize(bytes: self, options: options).asString
    }
    
}

// MARK: - Double Extension
extension Double {
    
    public static var min: Double {
        return DBL_MIN
    }
    
    public static var max: Double {
        return DBL_MAX
    }
    
    public var asInt: Int {
        return Int(self)
    }
    
    public var asUInt: UInt {
        return UInt(self)
    }
    
    public var asInt32: Int32 {
        return Int32(self)
    }
    
    public var asUInt32: UInt32 {
        return UInt32(self)
    }
    
    public var asInt64: Int64 {
        return Int64(self)
    }
    
    public var asUInt64: UInt64 {
        return UInt64(self)
    }
    
    public var asDouble: Double {
        return Double(self)
    }
    
    public var asFloat: Float {
        return Float(self)
    }
    
    public var asCGFloat: CGFloat {
        return CGFloat(self)
    }
    
    public var asDataSizeString: String {
        return asDataSizeString()
    }
    
    public func format(_ format: String = "") -> String {
        return String(format: "%\(format)f", self)
    }
    
    public func asDataSizeString(withFormattingOptions options: NSDataSizeFormattingOption = .Default) -> String {
        return asUInt64.asDataSizeString(withFormattingOptions: options)
    }
    
}

extension Float {
    
    public static var min: Float {
        return FLT_MIN
    }
    
    public static var max: Float {
        return FLT_MAX
    }
    
    public var asInt: Int {
        return Int(self)
    }
    
    public var asUInt: UInt {
        return UInt(self)
    }
    
    public var asInt32: Int32 {
        return Int32(self)
    }
    
    public var asUInt32: UInt32 {
        return UInt32(self)
    }
    
    public var asInt64: Int64 {
        return Int64(self)
    }
    
    public var asUInt64: UInt64 {
        return UInt64(self)
    }
    
    public var asDouble: Double {
        return Double(self)
    }
    
    public var asFloat: Float {
        return Float(self)
    }
    
    public var asCGFloat: CGFloat {
        return CGFloat(self)
    }
    
    public var asDataSizeString: String {
        return asDataSizeString()
    }
    
    public func format(_ format: String = "") -> String {
        return String(format: "%\(format)f", self)
    }
    
    public func asDataSizeString(withFormattingOptions options: NSDataSizeFormattingOption = .Default) -> String {
        return asUInt64.asDataSizeString(withFormattingOptions: options)
    }
    
}

extension CGFloat {
    
    public var inverse: CGFloat {
        return 1 / self
    }
    
    public var asInt: Int {
        return Int(self)
    }
    
    public var asUInt: UInt {
        return UInt(self)
    }
    
    public var asInt32: Int32 {
        return Int32(self)
    }
    
    public var asUInt32: UInt32 {
        return UInt32(self)
    }
    
    public var asInt64: Int64 {
        return Int64(self)
    }
    
    public var asUInt64: UInt64 {
        return UInt64(self)
    }
    
    public var asDouble: Double {
        return Double(self)
    }
    
    public var asFloat: Float {
        return Float(self)
    }
    
    public var asCGFloat: CGFloat {
        return CGFloat(self)
    }
    
    public var asDataSizeString: String {
        return asDataSizeString()
    }
    
    public func format(_ format: String = "") -> String {
        return String(format: "%\(format)f", self)
    }
    
    public func asDataSizeString(withFormattingOptions options: NSDataSizeFormattingOption = .Default) -> String {
        return asUInt64.asDataSizeString(withFormattingOptions: options)
    }
    
}

public struct NSDataSizeFormattingOption : OptionSet {
    
    public typealias RawValue = UInt
    public var rawValue: RawValue = 0
    
    public static let Abbreviated = NSDataSizeFormattingOption(rawValue: 1 << 0)
    public static let Capitalized = NSDataSizeFormattingOption(rawValue: 1 << 1)
    
    public static let Default: NSDataSizeFormattingOption = 
        [.Abbreviated, .Capitalized]
    
    public init(rawValue: RawValue) {
        self.rawValue = rawValue
    }
    
}

/// 
public struct NSDataSize : CustomStringConvertible {
    
    public let bytes: UInt64
    public let options: NSDataSizeFormattingOption
    
    public var asString: String {
        return "\(self)"
    }
    
    fileprivate (set) var suffix: [String] = ["byte", "b"]
    fileprivate (set) var size: Double = 0.0
    
    public init(bytes: UInt64, options: NSDataSizeFormattingOption = .Default) {
        
        self.bytes = bytes
        self.options = options
        
        size = bytes.asDouble
        var times = 0
        
        while size > 1024 {
            size = size / 1024
            times += 1
        }
        
        switch times {
        case 1 :
            suffix = ["kilobyte", "kb"]
            break
        case 2 :
            suffix = ["megabyte", "mb"]
            break
        case 3 :
            suffix = ["megabyte", "gb"]
            break
        case 4 :
            suffix = ["megabyte", "tb"]
            break
        default :
            break
        }
        
    }
    
    public var description: String {
        if options.contains(.Abbreviated) {
            let units = options.contains(.Capitalized) ?
                suffix[1].uppercased() : suffix[1]
            return "%.2f%@".format(size.asFloat, units)
        } else {
            var units = " " + suffix[0]
            units = options.contains(.Capitalized) ? 
                units.capitalized : units
            return String.pluralize("%.2f \(units)", size.asFloat)
        }
    }
    
}
