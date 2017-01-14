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

/// This protocol maps Swift data structures to analagous Core Foundation data
/// structures allowing the structure to be instantiated by either the Swift
/// `RawValue` associated type inherited from `RawRepresentable` or the Core
/// Foundation `CoreValue` associated type.
public protocol CFRawRepresentable : RawRepresentable {
    
    // MARK: - ** Associated Types **
    
    /// A Core Foundation data structure type (i.e. CFString)
    associatedtype CoreValue
    
    // MARK: - ** Static Properties **
    
    /// The default Swift form of this data structure
    static var DefaultRawValue: RawValue { get}
    
    /// The default Core Foundation form of this data structure
    static var DefaultCoreValue: CoreValue { get}
    
    // MARK: ** Public Properties **
    
    /// The Core Foundation form of this data structure
    var coreValue: CoreValue { get }
    
    // MARK: - ** Constructor Methods **
    
    /// Convenience constructor method
    /// - parameter rawValue: The Swift `RawValue` form of this data structure
    init(_ rawValue: RawValue)
    
    /// Convenience constructor method.
    ///
    /// - parameter rawValue?: The optional Swift `RawValue` form of this 
    /// data structure
    init?(_ rawValue: RawValue?)
    
    /// Convenience constructor method
    /// - parameter coreValue: The Core Foundation `CoreValue` form of this
    /// data structure
    init(_ coreValue: CoreValue)
    
    /// Convenience constructor method.
    ///
    /// - parameter coreValue?: The optional Core Foundation `CoreValue` form
    /// of this data structure
    init?(_ coreValue: CoreValue?)
    
}

extension CFRawRepresentable {
    
    /// Default optional convenience constructor method that handles an
    /// optional initial value parameter.
    /// - parameter rawValue: An optional initial raw value
    /// - returns: A `CFRawRepresentable` object initialized to `rawValue`
    /// if `rawValue` is not optional; `nil` otherwise.
    public init?(_ rawValue: RawValue?) {
        guard let rawValue = rawValue else { return nil }
        self.init(rawValue)
    }
    
    /// Default optional convenience constructor method that handles an
    /// optional initial value parameter.
    /// - parameter coreValue: An optional initial core value
    /// - returns: A `CFRawRepresentable` object initialized to `coreValue`
    /// if `coreValue` is not optional; `nil` otherwise.
    public init?(_ coreValue: CoreValue?) {
        guard let coreValue = coreValue else { return nil }
        self.init(coreValue)
    }
    
}


