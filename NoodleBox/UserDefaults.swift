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

/// Merges preferences from `rhs` with the data from `lhs`.
/// If a preference key already exists in `lhs` the value will be overwritten
/// by the value for that key in `rhs`.
/// - parameter lhs: The user defaults object to update
/// - parameter rhs: The property list containing new preferences
/// - returns: A user defaults object with data that has been merged with the
/// data from `rhs`.
public func + (lhs: UserDefaults, rhs: [String : Any]) -> UserDefaults {
    for (k, v) in rhs { lhs[k] = v }
    return lhs
}

/// Merges preferences from `rhs` into the `lhs` user defaults object.
/// If a preference key already exists in `lhs` the value will be overwritten
/// by the value for that key in `rhs`.
/// - parameter lhs: The user defaults object to update
/// - parameter rhs: The property list containing new preferences
public func += (lhs: inout UserDefaults, rhs: [String : Any]) {
    for (k, v) in rhs { lhs[k] = v }
}

// MARK: - ** NSUserDefaults Subscripting ** -

extension UserDefaults {

    /// Convenient subscripting access to/assignment of values via `key`
    open subscript (key: String) -> Any? {
        get { return object(forKey: key) as Any? }
        set { set(newValue, forKey: key) }
    }
    
    /// Alias for `dictionaryRepresentation`
    /// - returns: The dictionary representation of the user defaults object.
    open var dictionaryForm: [String : Any] {
        return dictionaryRepresentation()
    }

}

