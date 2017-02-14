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

// MARK: - String/NSString Casting Postfix Operators

/// Casts `argument` to an Objective-C `NSString` class instance.
public postfix func * (argument: String) -> NSString {
    return argument as NSString
}

/// Optionally, casts `argument` to an Objective-C `NSString` class instance.
public postfix func * (argument: String?) -> NSString? {
    return argument as NSString?
}

/// Casts `argument` to a Swift `String` data structure.
public postfix func * (argument: NSString) -> String {
    return argument as String
}

/// Optionally, casts `argument` to a Swift `String` data structure.
public postfix func * (argument: NSString?) -> String? {
    return argument as? String
}

// MARK: - String Concatenation Infix Operators

/// Duplicates `lhs`, `rhs` times and returns the joined string.
/// - parameter lhs: The string to duplicate.
/// - parameter rhs: The number of times to duplicate `lhs`.
/// - returns: A string that contains `rhs` joined substrings identical to `lhs`. 
public func * (lhs: String, rhs: Int) -> String {
    var str = ""
    for _ in 0 ..< rhs { str += lhs }
    return str
}

/// Conditionally concatenates two strings.
/// - parameter augend: The audend of this addition operation
/// - parameter addend: The addend of this addition operation
/// - returns: `augend` with `addend` concatenated at the end, or `nil` if
/// either `addend` is `nil`.
public func + (augend: String, addend: String?) -> String? {
    guard let addend = addend else { return nil }
    return augend + addend
}

/// Conditionally concatenates two strings.
/// - parameter augend: The audend of this addition operation
/// - parameter addend: The addend of this addition operation
/// - returns: `augend` with `addend` concatenated at the end, or `nil` if
/// either `augend` is `nil`.
public func + (augend: String?, addend: String) -> String? {
    guard let augend = augend else { return nil }
    return augend + addend
}
/// Conditionally concatenates two strings.
/// - parameter augend: The audend of this addition operation
/// - parameter addend: The addend of this addition operation
/// - returns: `augend` with `addend` concatenated at the end, or `nil` if
/// either `augend` or `addend` are `nil`.
public func + (augend: String?, addend: String?) -> String? {
    guard let augend = augend, let addend = addend else { return nil }
    return augend + addend
}

// MARK: - String Path Component Concatenation Infix Operators

/// 
public func +/ (lhs: String, rhs: String) -> String {
    return lhs.appendingPathComponent(rhs)
}

/// 
public func +/ (lhs: String, rhs: String?) -> String? {
    guard let rhs = rhs else { return nil }
    return lhs.appendingPathComponent(rhs)
}

/// 
public func +/ (lhs: String?, rhs: String) -> String? {
    guard let lhs = lhs else { return nil }
    return lhs.appendingPathComponent(rhs)
}

/// 
public func +/ (lhs: String?, rhs: String?) -> String? {
    guard let lhs = lhs, let rhs = rhs else { return nil }
    return lhs.appendingPathComponent(rhs)
}

/// 
public func +/ (lhs: String!, rhs: String) -> String {
    return lhs.appendingPathComponent(rhs)
}

/// 
public func +/ (lhs: String, rhs: String!) -> String {
    return lhs.appendingPathComponent(rhs)
}

/// 
public func +/ (lhs: String!, rhs: String!) -> String {
    return lhs.appendingPathComponent(rhs)
}

// MARK: - String Path Extension Concatenation Infix Operators

/// 
public func +> (lhs: String?, rhs: String?) -> String? {
    guard let lhs = lhs, let rhs = rhs else { return nil }
    return lhs.appendingPathExtension(rhs)
}

/// 
public func +> (lhs: String?, rhs: String) -> String? {
    guard let lhs = lhs else { return nil }
    return lhs.appendingPathExtension(rhs)
}

/// 
public func +> (lhs: String, rhs: String?) -> String? {
    guard let rhs = rhs else { return nil }
    return lhs.appendingPathExtension(rhs)
}

/// 
public func +> (lhs: String, rhs: String) -> String? {
    return lhs.appendingPathExtension(rhs)
}

// MARK: - String Statistics

extension String {
    
    /// The length of this string when represented as an `NSString`
    public var length: Int {
        return self*.length
    }
    
    /// The range representation of this string.
    /// - returns: `NSMakeRange(0, length)`
    public var range: NSRange {
        return NSMakeRange(0, length)
    }
    
    /// The number of words contained in this string.
    public var wordCount: Int {
        return components(separatedBy: .whitespaces).count - (length > 1 ? 1 : 0)
    }
    
    /// The number of lines contained in this string.
    public var lineCount: Int {
        return components(separatedBy: .newlines).count
    }
    
}

// MARK: - String Path Properties

extension String {

    /// All path components of this string.
    public var pathComponents: [String] {
        return self*.pathComponents
    }

    /// The last path component of this string.
    public var lastPathComponent: String {
        return self*.lastPathComponent
    }

    /// The path extension of this string.
    public var pathExtension: String {
        return self*.pathExtension
    }
    
}

// MARK: - String First/Last Character Getters

extension String {
    
    /// The first `Character` of this `String`.
    public var firstCharacter: Character? {
        return characters.first
    }

    /// The first character of this string represented as a `String`.
    public var firstCharacterString: String? {
        if length < 1 { return nil }
        return self.substring(to: 1)
    }
    
    /// The last `Character` of this `String`.
    public var lastCharacter: Character? {
        return characters.last
    }

    /// The last character of this string represented as a `String`.
    public var lastCharacterString: String? {
        if length < 1 { return nil }
        return self.substring(from: length - 1)
    }
    
}

// MARK: - String Contains

extension String {
    
    public func contains(_ loc: Int) -> Bool {
        return range.contains(loc)
    }
    
    public func contains(_ range: NSRange) -> Bool {
        return self.range.contains(range)
    }
    
}

// MARK: - String Pattern Matching

extension String {
    
    /// Returns whether or not at least one match is found in the parameter
    /// `string`, confining the search range to `range`, and using `self`
    /// as the regular expression pattern.
    /// - parameter string: The string to search for patterns.
    /// - parameter options: The matching options to use. See `NSMatchingOptions` for possible values. Default is `[.WithTransparentBounds]`.
    /// - parameter range: The range of the string to search.
    /// If set to `nil`, the range `NSMakeRange(0, string.length)` will be
    /// used instead.
    /// - returns: `true` if at least one match is found, `false` otherwise.
    
    public func matches(_ string: String, options: NSRegularExpression.MatchingOptions = [.withTransparentBounds], range: NSRange? = nil) -> Bool {
        return firstMatch(in: string, options: options, range: range) != nil
    }
    
    /// Returns whether or not at least one match is found in the parameter
    /// `string`, confining the search range to `range`, and using `self`
    /// as the regular expression pattern.
    /// - parameter string: The string to search for patterns.
    /// - parameter options: The matching options to use. See `NSSearchOptions` for possible values.
    /// - parameter range: The range of the string to search.
    /// If set to `nil`, the range `NSMakeRange(0, string.length)` will be
    /// used instead.
    /// - returns: `true` if at least one match is found, `false` otherwise.
    
    public func matches(_ string: String, searchOptions options: NSSearchOptions, range: NSRange? = nil) -> Bool {
        return firstMatch(in: string, searchOptions: options, range: range) != nil
    }
    
    /// Returns the first match in the parameter `string`, confining the search 
    /// range to `range`, and using `self` as the regular expression pattern,
    /// or `nil` if no match is found.
    /// - parameter string: The string to search for patterns.
    /// - parameter options: The matching options to use. See `NSMatchingOptions` for possible values. Default is `[.WithTransparentBounds]`.
    /// - parameter range: The range of the string to search.
    /// If set to `nil`, the range `NSMakeRange(0, string.length)` will be
    /// used instead.
    /// - returns: an `NSTextCheckingResult` object if a match is found,
    /// `false` otherwise.
    
    public func firstMatch(in string: String, options: NSRegularExpression.MatchingOptions = [.withTransparentBounds], range: NSRange? = nil) -> NSTextCheckingResult? {
        guard let expr = try? NSRegularExpression(pattern: self, options: []) else { return nil }
        guard let match = expr.firstMatch(in: string, options: options, range: range ?? string.range) else  { return nil }
        return match
    }
    
    /// Returns the first match in the parameter `string`, confining the search 
    /// range to `range`, and using `self` as the regular expression pattern,
    /// or `nil` if no match is found.
    /// - parameter string: The string to search for patterns.
    /// - parameter options: The matching options to use. See `NSSearchOptions`.
    /// - parameter range: The range of the string to search.
    /// If set to `nil`, the range `NSMakeRange(0, string.length)` will be
    /// used instead.
    /// - returns: an `NSTextCheckingResult` object if a match is found,
    /// `false` otherwise.
    
    public func firstMatch(in string: String, searchOptions options: NSSearchOptions, range: NSRange? = nil) -> NSTextCheckingResult? {
        guard let expr = try? NSRegularExpression(pattern: self, options: options.expressionOptions) else { return nil }
        guard let match = expr.firstMatch(in: string, options: options.matchingOptions, range: range ?? string.range) else  { return nil }
        return match
    }
    
    /// Returns all matches found in the parameter `string`, confining the
    /// search range to `range`, and using `self` as the regular expression
    /// pattern.
    /// - parameter string: The string to search for patterns.
    /// - parameter options: The matching options to use. See `NSMatchingOptions` for possible values. Default is `[.WithTransparentBounds]`.
    /// - parameter range: The range of the string to search.
    /// If set to `nil`, the range `NSMakeRange(0, string.length)` will be
    /// used instead.
    /// - returns: an `Array` of `NSTextCheckingResult` objects, or an empty
    /// `Array` if no matches are found.
    
    public func matches(in string: String, options: NSRegularExpression.MatchingOptions = [.withTransparentBounds], range: NSRange? = nil) -> [NSTextCheckingResult] {
        guard let expr = try? NSRegularExpression(pattern: self, options: []) else { return [] }
        return expr.matches(in: string, options: options, range: range ?? string.range)
    }
    
    /// Returns all matches found in the parameter `string`, confining the
    /// search range to `range`, and using `self` as the regular expression
    /// pattern.
    /// - parameter string: The string to search for patterns.
    /// - parameter options: The matching options to use. See `NSSearchOptions`.
    /// - parameter range: The range of the string to search.
    /// If set to `nil`, the range `NSMakeRange(0, string.length)` will be
    /// used instead.
    /// - returns: an `Array` of `NSTextCheckingResult` objects, or an empty
    /// `Array` if no matches are found.
    
    public func matches(in string: String, searchOptions options: NSSearchOptions, range: NSRange? = nil) -> [NSTextCheckingResult] {
        guard let expr = try? NSRegularExpression(pattern: self, options: options.expressionOptions) else { return [] }
        return expr.matches(in: string, options: options.matchingOptions, range: range ?? string.range)
    }
    
    /// Enumerates the string allowing the Block to handle each regular expression match.
    ///
    /// This method is the fundamental matching method for regular expressions and is suitable for overriding by subclassers. There are additional convenience methods for returning all the matches as an array, the total number of matches, the first match, and the range of the first match.
    ///
    /// By default, the Block iterator method calls the Block precisely once for each match, with a non-nilresult and the appropriate flags. The client may then stop the operation by setting the contents of stop to true. The stop argument is an out-only argument. You should only ever set this Boolean to true within the Block.
    ///
    /// If the NSMatchingReportProgress matching option is specified, the Block will also be called periodically during long-running match operations, with nil result and NSMatchingProgress matching flag set in the Block’s flags parameter, at which point the client may again stop the operation by setting the contents of stop to true.
    ///
    /// If the NSMatchingReportCompletion matching option is specified, the Block object will be called once after matching is complete, with nil result and the NSMatchingCompleted matching flag is set in the flags passed to the Block, plus any additional relevant NSMatchingFlags from among NSMatchingHitEnd, NSMatchingRequiredEnd, or NSMatchingInternalError.
    ///
    /// NSMatchingProgress and NSMatchingCompleted matching flags have no effect for methods other than this method.
    ///
    /// The NSMatchingHitEnd matching flag is set in the flags passed to the Block if the current match operation reached the end of the search range. The NSMatchingRequiredEnd matching flag is set in the flags passed to the Block if the current match depended on the location of the end of the search range.
    ///
    /// The NSMatchingFlags matching flag is set in the flags passed to the block if matching failed due to an internal error (such as an expression requiring exponential memory allocations) without examining the entire search range.
    ///
    /// The NSMatchingAnchored, NSMatchingWithTransparentBounds, and NSMatchingWithoutAnchoringBounds regular expression options, specified in the options property specified when the regular expression instance is created, can apply to any match or replace method.
    ///
    /// If NSMatchingAnchored matching option is specified, matches are limited to those at the start of the search range.
    ///
    /// If NSMatchingWithTransparentBounds matching option is specified, matching may examine parts of the string beyond the bounds of the search range, for purposes such as word boundary detection, lookahead, etc.
    ///
    /// If NSMatchingWithoutAnchoringBounds matching option is specified, ^ and $ will not automatically match the beginning and end of the search range, but will still match the beginning and end of the entire string.
    ///
    /// NSMatchingWithTransparentBounds and NSMatchingWithoutAnchoringBounds matching options have no effect if the search range covers the entire string.
    /// - parameter string: The string to search for patterns.
    /// - parameter options: The matching options to use. See `NSMatchingOptions` for possible values. Default is `[.WithTransparentBounds]`.
    /// - parameter range: The range of the string to search.
    /// If set to `nil`, the range `NSMakeRange(0, string.length)` will be
    /// used instead.
    /// - parameter block: The Block enumerates the matches of the regular expression in the string.
    /// The block takes three arguments:\
    /// \
    /// result\
    /// An NSTextCheckingResult specifying the match. This result gives the overall matched range via its range property, and the range of each individual capture group via its rangeAtIndex: method. The range {NSNotFound, 0} is returned if one of the capture groups did not participate in this particular match.\
    /// \
    /// flags\
    /// The current state of the matching progress. See NSMatchingFlags for the possible values.\
    /// \
    /// stop\
    /// A reference to a Boolean value. The Block can set the value to true to stop further processing of the array. The stop argument is an out-only argument. You should only ever set this Boolean to true within the Block.\
    /// \
    /// The Block returns void.
    ///
    public func enumerateMatches(in string: String, options: NSRegularExpression.MatchingOptions = [.withTransparentBounds], range: NSRange? = nil, usingBlock block: (NSTextCheckingResult?, NSRegularExpression.MatchingFlags, UnsafeMutablePointer<ObjCBool>) -> Void) {
        guard let expr = try? NSRegularExpression(pattern: self, options: []) else { return }
        expr.enumerateMatches(in: string, options: options, range: range ?? string.range, using: block)
    }
    
}

// MARK: - String Substrings

extension String {
    
    /// Returns a new string containing the characters of the receiver from the one at a given index to the end.
    ///
    /// A new string containing the characters of the receiver from the one at anIndex to the end. If anIndex is equal to the length of the string, returns an empty string.
    /// - parameter anIndex: An index. The value must lie within the bounds of the receiver, or be equal to the length of the receiver.\
    /// \
    /// Raises an NSRangeException if (anIndex - 1) lies beyond the end of the receiver.
    /// - returns: A new string containing the characters of the receiver from the one at `anIndex` to the end.
    
    public func substring(from index: Int) -> String {
        return self*.substring(from: index)
    }
    
    /// Returns a new string containing the characters of the receiver up to, but not including, the one at a given index.
    ///
    /// A new string containing the characters of the receiver from the one at anIndex to the end. If anIndex is equal to the length of the string, returns an empty string.
    /// - parameter anIndex: An index. The value must lie within the bounds of the receiver, or be equal to the length of the receiver.\
    /// \
    /// Raises an NSRangeException if (anIndex - 1) lies beyond the end of the receiver.
    /// - returns: A new string containing the characters of the receiver up to, but not including, the one at `anIndex`.
    
    public func substring(to index: Int) -> String {
        return self*.substring(to: index)
    }
    
    /// Returns a string object containing the characters of the receiver that lie within a given range.
    ///
    /// A string object containing the characters of the receiver that lie within aRange.
    /// 
    /// This method detects all invalid ranges (including those with negative lengths). For applications linked against OS X v10.6 and later, this error causes an exception; for applications linked against earlier releases, this error causes a warning, which is displayed just once per application execution.
    /// - parameter aRange: A range. The range must not exceed the bounds of the receiver.\
    /// \
    /// Raises an NSRangeException if (aRange.location - 1) or (aRange.location + aRange.length - 1) lies beyond the end of the receiver.
    /// - returns: A string object containing the characters of the receiver that lie within `aRange`.
    
    public func substring(with range: Range<Int>) -> String {
        guard self.range.contains(range*) else { return "" }
        return self*.substring(with: range*)
    }
    
    /// Returns a string object containing the characters of the receiver that lie within a given range.
    ///
    /// A string object containing the characters of the receiver that lie within aRange.
    ///
    /// This method detects all invalid ranges (including those with negative lengths). For applications linked against OS X v10.6 and later, this error causes an exception; for applications linked against earlier releases, this error causes a warning, which is displayed just once per application execution.
    /// - parameter aRange: A range. The range must not exceed the bounds of the receiver.\
    /// \
    /// Raises an NSRangeException if (aRange.location - 1) or (aRange.location + aRange.length - 1) lies beyond the end of the receiver.
    /// - returns: A string object containing the characters of the receiver that lie within `aRange`.
    
    public func substring(with range: NSRange) -> String {
        guard self.range.contains(range) else { return "" }
        return self*.substring(with: range)
    }
    
}

// MARK: - String Substring Enumeration

extension String {
    
    /// Enumerates the substrings of the specified type in the specified range of the string.
    /// 
    /// If this method is sent to an instance of NSMutableString, mutation (deletion, addition, or change) is allowed, as long as it is within enclosingRange. After a mutation, the enumeration continues with the range immediately following the processed range, after the length of the processed range is adjusted for the mutation. (The enumerator assumes any change in length occurs in the specified range.)
    /// 
    /// For example, if the block is called with a range starting at location N, and the block deletes all the characters in the supplied range, the next call will also pass N as the index of the range. This is the case even if mutation of the previous range changes the string in such a way that the following substring would have extended to include the already enumerated range. For example, if the string "Hello World" is enumerated via words, and the block changes "Hello " to "Hello", thus forming "HelloWorld", the next enumeration will return "World" rather than "HelloWorld".
    /// - parameter range: The range within the string to enumerate substrings.
    /// - parameter opts: Options specifying types of substrings and enumeration styles.
    /// - parameter block: The block executed for the enumeration.
    /// \
    /// The block takes four arguments:
    /// substring
    /// \
    /// The enumerated string.\
    /// \
    /// substringRange
    /// \
    /// The range of the enumerated string in the receiver.\
    /// \
    /// enclosingRange
    /// \
    /// The range that includes the substring as well as any separator or filler characters that follow. For instance, for lines, enclosingRange contains the line terminators. The enclosingRange for the first string enumerated also contains any characters that occur before the string. Consecutive enclosing ranges are guaranteed not to overlap, and every single character in the enumerated range is included in one and only one enclosing range.\
    /// \
    /// stop
    /// \
    /// A reference to a Boolean value that the block can use to stop the enumeration by setting *stop = YES; it should not touch *stop otherwise.
    public func enumerateSubstrings(in range: NSRange, options opts: NSString.EnumerationOptions, usingBlock block: @escaping (String?, NSRange, NSRange, UnsafeMutablePointer<ObjCBool>) -> Void) {
        self*.enumerateSubstrings(in: range, options: opts, using: block)
    }
    
    /// Enumerates the substrings of the specified type in the specified range of the string.
    /// 
    /// If this method is sent to an instance of NSMutableString, mutation (deletion, addition, or change) is allowed, as long as it is within enclosingRange. After a mutation, the enumeration continues with the range immediately following the processed range, after the length of the processed range is adjusted for the mutation. (The enumerator assumes any change in length occurs in the specified range.)
    /// 
    /// For example, if the block is called with a range starting at location N, and the block deletes all the characters in the supplied range, the next call will also pass N as the index of the range. This is the case even if mutation of the previous range changes the string in such a way that the following substring would have extended to include the already enumerated range. For example, if the string "Hello World" is enumerated via words, and the block changes "Hello " to "Hello", thus forming "HelloWorld", the next enumeration will return "World" rather than "HelloWorld".
    /// - parameter range: The range within the string to enumerate substrings.
    /// - parameter opts: Options specifying types of substrings and enumeration styles.
    /// - parameter block: The block executed for the enumeration.
    /// \
    /// The block takes four arguments:
    /// substring
    /// \
    /// The enumerated string.\
    /// \
    /// substringRange
    /// \
    /// The range of the enumerated string in the receiver.\
    /// \
    /// enclosingRange
    /// \
    /// The range that includes the substring as well as any separator or filler characters that follow. For instance, for lines, enclosingRange contains the line terminators. The enclosingRange for the first string enumerated also contains any characters that occur before the string. Consecutive enclosing ranges are guaranteed not to overlap, and every single character in the enumerated range is included in one and only one enclosing range.\
    /// \
    /// stop
    /// \
    /// A reference to a Boolean value that the block can use to stop the enumeration by setting *stop = YES; it should not touch *stop otherwise.
    public func enumerateSubstrings(in range: Range<Int>, options opts: NSString.EnumerationOptions, usingBlock block: @escaping (String?, NSRange, NSRange, UnsafeMutablePointer<ObjCBool>) -> Void) {
        self*.enumerateSubstrings(in: range*, options: opts, using: block)
    }
    
}

// MARK: - String Replacement

extension String {
    
    /// Returns a new string in which the characters in a specified range of the receiver are replaced by a given string.
    ///
    /// A new string in which the characters in range of the receiver are replaced by replacement.
    /// - parameter range: A range of characters in the receiver.
    /// - parameter replacement: The string with which to replace the characters in range.
    /// - returns: A new string in which the characters in range of the receiver are replaced by replacement.
    @available(iOS 2.0, *)
    public func replacingCharacters(in range: NSRange, withString replacement: String) -> String {
        return self*.replacingCharacters(in: range, with: replacement)
    }
    
    /// Returns a new string in which all occurrences of a target string in a specified range of the receiver are replaced by another given string.
    /// - parameter target: The string to replace.
    /// - parameter replacement: The string with which to replace target.
    /// - parameter options: A mask of options to use when comparing target with the receiver. Pass 0 to specify no options.
    /// - parameter range: The range in the receiver in which to search for target.
    /// - returns: A new string in which all occurrences of target, matched using options, in searchRange of the receiver are replaced by replacement.
    public func replacingOccurrences(of target: String, with replacement: String, options: NSString.CompareOptions, range: NSRange) -> String {
        return self*.replacingOccurrences(of: target, with: replacement, options: options, range: range)
    }
 
    /// Returns a new string in which all occurrences of a target string in a specified range of the receiver are replaced by another given string.
    /// - parameter replacements: A mapping of target-replacement strings.
    /// - parameter options: A mask of options to use when comparing target with the receiver. Pass 0 to specify no options.
    /// - parameter range: The range in the receiver in which to search for target.
    /// - returns: A new string in which all occurrences of target, matched using options, in searchRange of the receiver are replaced by replacement.
    public func replacingOccurrences(of replacements: [String : String], options: NSString.CompareOptions, range: NSRange) -> String {
        var string = self
        for (target, replacement) in replacements {
            string = replacingOccurrences(of: target, with: replacement, options: options, range: range)
        }
        return string
    }
    
    /// Returns a new string in which all occurrences of escapable characters
    /// are replaced with literal string values.
    /// - returns: A new string in which all occurrences of escapable characters
    /// are replaced with literal string values.
    public func escapingWhitespaces() -> String {
        return replacingOccurrences(of: ["\n" : "\\n", "\t": "\\t", " " : "\\s"], options: [], range: range)
    }
    
}

// MARK: - String Mutating Replacements

extension String {
    
    /// Mutates `self` in which the characters in a specified range of the `self` are replaced by a given string.
    /// - parameter range: A range of characters in the receiver.
    /// - parameter replacement: The string with which to replace the characters in range.
    @available(iOS 2.0, *)
    public mutating func replace(range: NSRange, withString replacement: String) {
        self = self.replacingCharacters(in: range, withString: replacement)
    }
    
    /// Replaces all occurrences of `target` in `self` with `replacement`.
    /// - parameter target: The string to search for.
    /// - parameter replacement: The string used to replace `target` with.
    public mutating func replaceOccurrences(of target: String, with replacement: String) {
        self = self.replacingOccurrences(of: target, with: replacement)
    }
    
}

// MARK: - String Escaping

extension String {
    
    /// Removes all escaped characters/substrings with their literal value 
    /// and returns the resultant string.
    public var withoutEscapes: String {
        let str = NSMutableString(string: self)
        if let expr = try? NSRegularExpression(pattern: "\\\\([:\\-.*\\^$!?(){}\\[\\]])", options: []) {
            expr.replaceMatches(in: str, options: [.withTransparentBounds], range: str.range, withTemplate: "$1")
        }
        if let expr = try? NSRegularExpression(pattern: "\\(\\?\\<\\=.*?\\)", options: []) {
            expr.replaceMatches(in: str, options: [.withTransparentBounds], range: str.range, withTemplate: "")
        }
        if let expr = try? NSRegularExpression(pattern: "\\(\\?\\!.*?\\)", options: []) {
            expr.replaceMatches(in: str, options: [.withTransparentBounds], range: str.range, withTemplate: "")
        }
        return str as String
    }
    
    /// Generates a regular expression pattern string from `self`. 
    /// - postcondition: The returned pattern string will match `self`.
    public var regexPattern: String {
        let pattern = NSMutableString(string: self)
        let expr = try! NSRegularExpression(pattern: "([\\{\\}\\(\\)\\[\\]\\*\\|\\.\\:\\?\\!\\<\\>\\=\\+\\$\\^])", options: [])
        expr.replaceMatches(in: pattern, options: [], range: pattern.range, withTemplate: "\\\\$1")
        return pattern as String
    }
    
}

// MARK: - String Paragraph Ranges

extension String {
    
    /// Returns the range of characters representing the paragraph or 
    /// paragraphs containing a given range.
    ///
    /// The range of characters representing the paragraph or paragraphs 
    /// containing aRange, including the paragraph termination characters.
    /// - parameter range: A range within the receiver. The range must not 
    /// exceed the bounds of the receiver.
    /// - returns: The range of characters representing the paragraph or
    /// paragraphs containing aRange, including the paragraph termination characters.
    @available(iOS 8.0, *)
    
    public func paragraphRange(for range: Range<Int>) -> NSRange {
        return self*.paragraphRange(for: range*)
    }
    
    /// Returns the range of characters representing the paragraph or 
    /// paragraphs containing a given range.
    ///
    /// The range of characters representing the paragraph or paragraphs 
    /// containing aRange, including the paragraph termination characters.
    /// - parameter range: A range within the receiver. The range must not 
    /// exceed the bounds of the receiver.
    /// - returns: The range of characters representing the paragraph or
    /// paragraphs containing aRange, including the paragraph termination characters.
    @available(iOS 8.0, *)
    
    public func paragraphRange(for range: NSRange) -> NSRange {
        guard self.range.contains(range) else { return range }
        return self*.paragraphRange(for: range)
    }
    
}

// MARK: - String Exploding

extension String {

    /// Separates components using a regular expression pattern
    /// - parameter pattern: The delimiter expression to match.
    /// - parameter template: The template used to replace matches with before
    /// separation. Default is `««`. 
    /// - note: `template` should be a unique pattern distinguishable from
    /// `pattern` or any regular expression control characters/patterns.
    public func components(separatedByPattern pattern: String, template: String = "««") -> [String] {
        guard let expr = try? NSRegularExpression(pattern: pattern, options: []) else { return [] }
        let string = NSMutableString(string: self)
        expr.replaceMatches(in: string, options: [.withTransparentBounds], range: string.range, withTemplate: template)
        return string.components(separatedBy: template)
    }
    
    /// 
    /// 
    /// 
    /// 
    public func replacingMatches(of pattern: String, with template: String) -> String {
        let string = NSMutableString(string: self)
        _ = try? NSRegularExpression(pattern: pattern, options: []).replaceMatches(in: string, options: [], range: string.range, withTemplate: template)
        return string as String
    }
    
    /// 
    /// 
    /// 
    /// 
    public mutating func replaceMatches(of pattern: String, with template: String) {
        self = replacingMatches(of: pattern, with: template)
    }
    
}

// MARK: - String Whitespaces

extension String {

    /// The substring of leading whitespaces, if any.
    public var leadingWhitespaces: String {
        guard let expr = try? NSRegularExpression(pattern: "^[ \\t]*", options: []),
            let match = expr.firstMatch(in: self, options: [], range: range) else { return "" }
        return substring(with: match.range)
    }
    
    /// The substring of trailing whitespaces, if any.
    public var trailingWhitespaces: String {
        guard let expr = try? NSRegularExpression(pattern: "[ \\t]*$", options: []),
            let match = expr.firstMatch(in: self, options: [], range: range) else { return "" }
        return substring(with: match.range)
    }
    
}

// MARK: - String Substring Indexing

extension String {
    
    /// Finds and returns the range of the first occurrence of a given string, within the given range of the receiver, subject to given options.
    /// 
    /// An NSRange structure giving the location and length in the receiver of aString within aRange in the receiver, modulo the options in mask. The range returned is relative to the start of the string, not to the passed-in range. Returns {NSNotFound, 0} if aString is not found or is empty (@"").
    /// 
    /// This method detects all invalid ranges (including those with negative lengths). For applications linked against OS X v10.6 and later, this error causes an exception; for applications linked against earlier releases, this error causes a warning, which is displayed just once per application execution.
    /// - parameter aString: The string for which to search. \
    /// \
    /// This value must not be nil.
    /// Raises an NSInvalidArgumentException if aString is nil.
    /// - parameter mask: A mask specifying search options. The following options may be specified by combining them with the C bitwise OR operator: NSCaseInsensitiveSearch, NSLiteralSearch, NSBackwardsSearch, NSAnchoredSearch. See String Programming Guide for details on these options.
    /// - parameter aRange: The range within the receiver for which to search for aString.
    /// Raises an NSRangeException if aRange is invalid.
    /// - returns: An NSRange structure giving the location and length in the receiver of aString within aRange in the receiver, modulo the options in mask.
    public func range(of string: String, options mask: NSString.CompareOptions, range aRange: NSRange) -> NSRange? {
        let foundRange = self*.range(of: string, options: mask, range: aRange)
        if foundRange.location == NSNotFound { return nil }
        return foundRange
    }
    
}

// MARK: - String Trimming

extension String {
    
    /// Removes the leading and trailing whitespace characters of `self` and
    /// returns the result.
    public var trimmed: String {
        return trimmingCharacters(in: .whitespaces)
    }

    /// Removes the last path component of `self` and returns the result.
    public var deletingLastPathComponent: String {
        return self*.deletingLastPathComponent
    }

    /// Removes the path extension of `self` and returns the result.
    public var deletingPathExtension: String {
        return self*.deletingPathExtension
    }
    
    /// Removes all occurrences of `"/"` and returns the result.
    public var removingPathDelimiters: String {
        return removingOccurrences(of: "/")
    }
    
    /// Removes all occurrences of `string` and returns the result.
    public func removingOccurrences(of str: String) -> String {
        return replacingOccurrences(of: str, with: "")
    }
    
}

// MARK: - String URL Casting

extension String {

    /// Returns a `NSURL` representation of `self`.
    public var url: URL {
        return URL(fileURLWithPath: self)
    }
    
}

// MARK: - String Path/Extension Concatentation

extension String {

    /// Returns a new string made by appending to the receiver a given string.
    ///
    /// A new string made by appending aString to the receiver, preceded if necessary by a path separator.
    /// - parameter str: The path component to append to the receiver.
    /// - returns: A new string made by appending aString to the receiver, 
    /// preceded if necessary by a path separator.
    public func appendingPathComponent(_ str: String) -> String {
        return self*.appendingPathComponent(str)
    }

    /// Returns a new string made by appending to the receiver an extension separator followed by a given extension.
    /// 
    /// A new string made by appending to the receiver an extension separator followed by ext.
    /// 
    /// Prior to OS X v10.9 this method did not allow you to append file extensions to filenames starting with the tilde character (~).
    /// - parameter str: The extension to append to the receiver.
    /// - returns: A new string made by appending aString to the receiver, 
    /// preceded if necessary by a path separator.
    public func appendingPathExtension(_ str: String) -> String? {
        return self*.appendingPathExtension(str)
    }
    
}

// MARK: - String Formatting

extension String {
    
    /// Formats the string taking any number of arguments and interpolating 
    /// their values.
    /// - parameter format: the arguments to interpolate into this string
    /// - returns: An interpolated string
    public func format(_ format: CVarArg...) -> String {
        return (String(format: self, arguments: format))
    }
    
}

// MARK: - String Size Estimation

extension String {

    // MARK: Dimension Methods
    
    /// Returns the bounding box size the receiver occupies when drawn with the given attributes.
    /// 
    /// The bounding box size the receiver occupies when drawn with the specified attributes.
    /// - parameter attrs: A dictionary of text attributes to be applied to the string. These are the same attributes that can be applied to an NSAttributedString object, but in the case of NSString objects, the attributes apply to the entire string, rather than ranges within the string.
    /// - returns: The bounding box size the receiver occupies when drawn with the specified attributes.
    public func size(attributes attrs: [String : Any]) -> CGSize {
        return self*.size(attributes: attrs)
    }

    /// Calculates and returns the width of the bounding rect for the receiver drawn using the given options and display characteristics, within the specified rectangle in the current graphics context.
    /// The width of the bounding rect for the receiver drawn using the given options and display characteristics. The rect origin returned from this method is the first glyph origin.
    /// - parameter height: The constrained height of the drawing bounds
    /// - parameter attrs: The attributes to apply to the string
    /// - returns: The width of the bounding rect for the receiver drawn using the given options and display characteristics.
    public func width(whenConstrainedToHeight height: CGFloat = .greatestFiniteMagnitude, withAttributes attrs: [String : Any]? = nil) -> CGFloat {
        let attrs = attrs ?? [NSFontAttributeName : UIFont.systemFont()]
        let constraintRect = CGSize(width: height, height: .greatestFiniteMagnitude)
        let boundingBox = self*.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attrs, context: nil)
        return boundingBox.width
    }

    /// Calculates and returns the height of the bounding rect for the receiver drawn using the given options and display characteristics, within the specified rectangle in the current graphics context.
    /// The height of the bounding rect for the receiver drawn using the given options and display characteristics. The rect origin returned from this method is the first glyph origin.
    /// - parameter width: The constrained width of the drawing bounds
    /// - parameter attrs: The attributes to apply to the string
    /// - returns: The height of the bounding rect for the receiver drawn using the given options and display characteristics.
    public func height(whenConstrainedToWidth width: CGFloat = .greatestFiniteMagnitude, withAttributes attrs: [String : Any]? = nil) -> CGFloat {
        let attrs = attrs ?? [NSFontAttributeName : UIFont.systemFont()]
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self*.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attrs, context: nil)
        return boundingBox.height
    }

}

// MARK: - String Image Rendering

extension String {
    
    /// Returns `self` as an image with `attrs` and dimensions `size`.
    /// - parameter attrs: The text attributes to use for text rendering.
    /// - parameter size: The size of the return image.
    /// - returns: An `UIImage` representation of `self` with `attrs` text
    /// attributes and dimensions `size`.
    
    public func image(attributes attrs: [String : Any], size: CGSize? = nil) -> UIImage {
        let size = size ?? self.size(attributes: attrs)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0);
        // draw in context, you can use also drawInRect:withFont:
        self*.draw(at: CGPoint(x: 0.0, y: 0.0), withAttributes: attrs)
        // transfer image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()  
        return image!
    }
    
    /// Returns `self` with system font as an image with dimensions `size`.
    /// - parameter size: The size of the return image.
    /// - returns: An `UIImage` representation of `self` with system font
    /// and dimensions `size`.
    
    public func image(size: CGSize) -> UIImage {
        return image(attributes: [NSFontAttributeName : UIFont.systemFont()], size: size)
    }
    
}

// MARK: - String As File Path Methods

extension String {
    
    /// Returns whether or not a file exists at the path `self`.
    public var fileExists: Bool {
        return FileManager.default.fileExists(atPath: self)
    }
    
    /// Returns whether or not the file at path `self` is a directory
    public var directory: Bool {
        var directory: ObjCBool = false
        FileManager.default.fileExists(atPath: self, isDirectory: &directory)
        return directory.boolValue
    }
    
}

// MARK: - String Localization

extension String {
    
    /// Returns `self` with only the first character captialized.
    public var properString: String {
        let first = String(characters.prefix(1)).uppercased()
        let other = String(characters.dropFirst())
        return first + other
    }
    
    /// 
    public var localizedString: String {
        return NSLocalizedString(self, comment: "")
    }
    
    /// 
    public var capitalizedLocalizedString: String {
        return localizedString.capitalized
    }
    
    /// 
    public var properLocalizedString: String {
        return localizedString.properString
    }
    
    /// 
    public static func pluralize(_ string: String, _ count: CVarArg) -> String {
        return String.localizedStringWithFormat(NSLocalizedString(string, comment: ""), count)
    }  
    
    /// 
    public static func capitalizedLocalizedString(_ key: String) -> String {
        let str = NSLocalizedString(key, comment: "")
        return str.capitalizedLocalizedString
    }
    
    ///
    public func pluralize(_ count: CVarArg) -> String {
        return String.localizedStringWithFormat(NSLocalizedString(self, comment: ""), count)
    }
    
}

// MARK: - String Regular Expression Methods

extension String {
    
    /// 
    public var shortestRegexMatch: String {
        
        let pattern = NSMutableString(string: self)
        
        if let expr = try? NSRegularExpression(pattern: "(\\\\[b])|(\\(\\?(:|<=|<!|=|!).*?\\))", options: []) {
            expr.replaceMatches(in: pattern, options: [], range: pattern.range, withTemplate: "")
        }
        
        if let expr = try? NSRegularExpression(pattern: "(\\\\[swBSW])", options: []) {
            expr.replaceMatches(in: pattern, options: [], range: pattern.range, withTemplate: ".")
        }
        
        if let expr = try? NSRegularExpression(pattern: "\\\\[?!(){}^$*:|[=\\]]", options: []) {
            var match = expr.firstMatch(in: pattern as String, options: [], range: pattern.range)
            while match != nil {
                pattern.replaceCharacters(in: match!.range, with: pattern.substring(with: NSMakeRange(match!.range.location + 1, 1)))
                match = expr.firstMatch(in: pattern as String, options: [], range: pattern.range)
            }
        }
        
        if let expr = try? NSRegularExpression(pattern: "\\(\\?\\=\\(((\\\\\\()|[^(])*\\)", options: []) {
            var match = expr.firstMatch(in: pattern as String, options: [], range: pattern.range)
            while match != nil {
                pattern.replaceCharacters(in: match!.range, with: "")
                match = expr.firstMatch(in: pattern as String, options: [], range: pattern.range)
            }
        }
        
        if let expr = try? NSRegularExpression(pattern: "(\\((\\\\\\(|[^(])*\\)|\\[(\\\\\\[|[^[])*\\]|.)[*?]", options: []) {
            var match = expr.firstMatch(in: pattern as String, options: [], range: pattern.range)
            while match != nil {
                pattern.replaceCharacters(in: match!.range, with: "")
                match = expr.firstMatch(in: pattern as String, options: [], range: pattern.range)
            }
        }
        
        if let expr = try? NSRegularExpression(pattern: "(\\[(\\\\\\[|[^[])*\\]|.)[+]", options: []) {
            var match = expr.firstMatch(in: pattern as String, options: [], range: pattern.range)
            while match != nil {
                pattern.replaceCharacters(in: match!.range, with: ".")
                match = expr.firstMatch(in: pattern as String, options: [], range: pattern.range)
            }
        }
        
        if let expr = try? NSRegularExpression(pattern: "(\\((\\\\\\(|[^(])*\\)[+]", options: []) {
            expr.replaceMatches(in: pattern, options: [], range: pattern.range, withTemplate: "$1")
        }
        
        if let expr = try? NSRegularExpression(pattern: "\\{[0-9]*,.*?\\}", options: []) {
            var match = expr.firstMatch(in: pattern as String, options: [], range: pattern.range)
            while match != nil {
                pattern.replaceCharacters(in: match!.range, with: "")
                match = expr.firstMatch(in: pattern as String, options: [], range: pattern.range)
            }
        }
        
        if let expr = try? NSRegularExpression(pattern: "\\((\\\\\\(|[^(])*\\)", options: []) {
            
            var result = expr.firstMatch(in: pattern as String, options: [], range: pattern.range)
            while result != nil {
                let substring = pattern.substring(with: NSMakeRange(result!.range.location + 1, result!.range.length - 2))
                var word = substring
                let multiplicity = 1
                for string in substring.components(separatedBy: "|") {
                    if string.length < word.length  {
                        word = string
                    }
                }
                pattern.replaceCharacters(in: result!.range, with: word * multiplicity)
                result = expr.firstMatch(in: pattern as String, options: [], range: pattern.range)
            }
            
        }
        
        return pattern as String
        
    }
    
    /// 
    public var minRegexMatchLength: Int {
        return shortestRegexMatch.length
    }
    
}




