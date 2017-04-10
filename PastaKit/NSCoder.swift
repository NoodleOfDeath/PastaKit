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

extension NSCoder {
    
    /// Encodes an `_ObjectiveCBridgeable` data structure.
    /// - important: The objective-c class being bridged to must conform to
    /// `NSCoding`.
    /// - parameter object: The object to encode.
    open func encode<T: _ObjectiveCBridgeable>(_ object: T?) {
        encode(object?._bridgeToObjectiveC())
    }
    
    /// Encodes an `_ObjectiveCBridgeable` data structure as a root object.
    /// - important: The objective-c class being bridged to must conform to
    /// `NSCoding`.
    /// - parameter object: The object to encode.
    open func encodeRootObject<T: _ObjectiveCBridgeable>(_ object: T) {
        encodeRootObject(object._bridgeToObjectiveC())
    }
    
    /// Encodes an `_ObjectiveCBridgeable` conditional data structure.
    /// - important: The objective-c class being bridged to must conform to
    /// `NSCoding`.
    /// - parameter object: The object to encode.
    open func encodeConditionalObject<T: _ObjectiveCBridgeable>(_ object: T?) {
        encodeConditionalObject(object?._bridgeToObjectiveC())
    }
    
    /// Encodes an `_ObjectiveCBridgeable` data structure and maps it to a 
    /// specific `key`.
    /// - important: The objective-c class being bridged to must conform to
    /// `NSCoding`.
    /// - parameter object: The object to encode.
    /// - parameter key: The key to associate with this object.
    open func encode<T: _ObjectiveCBridgeable>(_ object: T?, forKey key: String) {
        encode(object?._bridgeToObjectiveC(), forKey: key)
    }
    
    /// Encodes an `_ObjectiveCBridgeable` conditional data structure and maps
    /// it to a specific `key`.
    /// - important: The objective-c class being bridged to must conform to
    /// `NSCoding`.
    /// - parameter object: The object to encode.
    /// - parameter key: The key to associate with this object.
    open func encodeConditionalObject<T: _ObjectiveCBridgeable>(_ object: T?, forKey key: String) {
        encodeConditionalObject(object?._bridgeToObjectiveC(), forKey: key)
    }
    
}



