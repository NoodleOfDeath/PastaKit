//
//  String.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 3/8/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

// MARK: - ** Import Modules **

import UIKit

// MARK: - ** Operation Methods **

// MARK: - String and NSString Casting

/// Casts `argument` to an Objective-C `NSString` class instance.
public postfix func * (argument: String) -> NSString {
    return argument
}

/// Optionally, casts `argument` to an Objective-C `NSString` class instance.
public postfix func * (argument: String?) -> NSString? {
    return argument
}

/// Casts `argument` to a Swift `String` data structure.
public postfix func * (argument: NSString) -> String {
    return argument as String
}

/// Optionally, casts `argument` to a Swift `String` data structure.
public postfix func * (argument: NSString?) -> String? {
    return argument as? String
}

// MARK: - String Concatenation

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
    return augend.stringByAppendingString(addend)
}

/// Conditionally concatenates two strings.
/// - parameter augend: The audend of this addition operation
/// - parameter addend: The addend of this addition operation
/// - returns: `augend` with `addend` concatenated at the end, or `nil` if
/// either `augend` is `nil`.
public func + (augend: String?, addend: String) -> String? {
    guard let augend = augend else { return nil }
    return augend.stringByAppendingString(addend)
}
/// Conditionally concatenates two strings.
/// - parameter augend: The audend of this addition operation
/// - parameter addend: The addend of this addition operation
/// - returns: `augend` with `addend` concatenated at the end, or `nil` if
/// either `augend` or `addend` are `nil`.
public func + (augend: String?, addend: String?) -> String? {
    guard let augend = augend, let addend = addend else { return nil }
    return augend.stringByAppendingString(addend)
}

// MARK: - Path Component Concatenation

/// 
public func +/ (lhs: String, rhs: String) -> String {
    return lhs.stringByAppendingPathComponent(rhs)
}

/// 
public func +/ (lhs: String, rhs: String?) -> String? {
    guard let rhs = rhs else { return nil }
    return lhs.stringByAppendingPathComponent(rhs)
}

/// 
public func +/ (lhs: String?, rhs: String) -> String? {
    guard let lhs = lhs else { return nil }
    return lhs.stringByAppendingPathComponent(rhs)
}

/// 
public func +/ (lhs: String?, rhs: String?) -> String? {
    guard let lhs = lhs, let rhs = rhs else { return nil }
    return lhs.stringByAppendingPathComponent(rhs)
}

// MARK: - Path Extension Concatenation

/// 
public func +* (lhs: String?, rhs: String?) -> String? {
    guard let lhs = lhs, let rhs = rhs else { return nil }
    return lhs.stringByAppendingPathExtension(rhs)
}

/// 
public func +* (lhs: String?, rhs: String) -> String? {
    guard let lhs = lhs else { return nil }
    return lhs.stringByAppendingPathExtension(rhs)
}

/// 
public func +* (lhs: String, rhs: String?) -> String? {
    guard let rhs = rhs else { return nil }
    return lhs.stringByAppendingPathExtension(rhs)
}

/// 
public func +* (lhs: String, rhs: String) -> String? {
    return lhs.stringByAppendingPathExtension(rhs)
}

// MARK: - ** String General Properties **

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
        return self.componentsSeparatedByCharactersInSet(.whitespaceCharacterSet()).count - (length > 1 ? 1 : 0)
    }
    
    /// The number of lines contained in this string.
    public var lineCount: Int {
        return self.componentsSeparatedByCharactersInSet(.newlineCharacterSet()).count
    }
    
}

// MARK: - ** String Path Properties **

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

// MARK: - ** String Character Properties **

extension String {
    
    /// The first `Character` of this `String`.
    public var firstCharacter: Character? {
        return characters.first
    }

    /// The first character of this string represented as a `String`.
    public var firstCharacterString: String? {
        if length < 1 { return nil }
        return self.substringToIndex(1)
    }
    
    /// The last `Character` of this `String`.
    public var lastCharacter: Character? {
        return characters.last
    }

    /// The last character of this string represented as a `String`.
    public var lastCharacterString: String? {
        if length < 1 { return nil }
        return self.substringFromIndex(length - 1)
    }
    
}

// MARK: - ** String Pattern Matching Methods **

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
    public func matches(string: String, options: NSMatchingOptions = [.WithTransparentBounds], range: NSRange? = nil) -> Bool {
        return firstMatchInString(string, options: options, range: range) != nil
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
    public func matches(string: String, searchOptions options: NSSearchOptions, range: NSRange? = nil) -> Bool {
        return firstMatchInString(string, searchOptions: options, range: range) != nil
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
    public func firstMatchInString(string: String, options: NSMatchingOptions = [.WithTransparentBounds], range: NSRange? = nil) -> NSTextCheckingResult? {
        guard let expr = try? NSRegularExpression(pattern: self, options: []) else { return nil }
        guard let match = expr.firstMatchInString(string, options: options, range: range ?? string.range) else  { return nil }
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
    public func firstMatchInString(string: String, searchOptions options: NSSearchOptions, range: NSRange? = nil) -> NSTextCheckingResult? {
        guard let expr = try? NSRegularExpression(pattern: self, options: options.expressionOptions) else { return nil }
        guard let match = expr.firstMatchInString(string, options: options.matchingOptions, range: range ?? string.range) else  { return nil }
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
    public func matchesInString(string: String, options: NSMatchingOptions = [.WithTransparentBounds], range: NSRange? = nil) -> [NSTextCheckingResult] {
        guard let expr = try? NSRegularExpression(pattern: self, options: []) else { return [] }
        return expr.matchesInString(string, options: options, range: range ?? string.range)
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
    public func matchesInString(string: String, searchOptions options: NSSearchOptions, range: NSRange? = nil) -> [NSTextCheckingResult] {
        guard let expr = try? NSRegularExpression(pattern: self, options: options.expressionOptions) else { return [] }
        return expr.matchesInString(string, options: options.matchingOptions, range: range ?? string.range)
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
    public func enumerateMatchesInString(string: String, options: NSMatchingOptions = [.WithTransparentBounds], range: NSRange? = nil, usingBlock block: (NSTextCheckingResult?, NSMatchingFlags, UnsafeMutablePointer<ObjCBool>) -> Void) {
        guard let expr = try? NSRegularExpression(pattern: self, options: []) else { return }
        expr.enumerateMatchesInString(string, options: options, range: range ?? string.range, usingBlock: block)
    }
    
}

// MARK: - ** String Substrings **

extension String {
    
    /// Returns a new string containing the characters of the receiver from the one at a given index to the end.
    ///
    /// A new string containing the characters of the receiver from the one at anIndex to the end. If anIndex is equal to the length of the string, returns an empty string.
    /// - parameter anIndex: An index. The value must lie within the bounds of the receiver, or be equal to the length of the receiver.\
    /// \
    /// Raises an NSRangeException if (anIndex - 1) lies beyond the end of the receiver.
    /// - returns: A new string containing the characters of the receiver from the one at `anIndex` to the end.
    public func substringFromIndex(anIndex: Int) -> String {
        return self*.substringFromIndex(anIndex)
    }
    
    /// Returns a new string containing the characters of the receiver up to, but not including, the one at a given index.
    ///
    /// A new string containing the characters of the receiver from the one at anIndex to the end. If anIndex is equal to the length of the string, returns an empty string.
    /// - parameter anIndex: An index. The value must lie within the bounds of the receiver, or be equal to the length of the receiver.\
    /// \
    /// Raises an NSRangeException if (anIndex - 1) lies beyond the end of the receiver.
    /// - returns: A new string containing the characters of the receiver up to, but not including, the one at `anIndex`.
    public func substringToIndex(anIndex: Int) -> String {
        return self*.substringToIndex(anIndex)
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
    public func substringWithRange(aRange: IntRange) -> String {
        guard self.range.contains(aRange*) else { return "" }
        return self*.substringWithRange(aRange*)
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
    public func substringWithRange(range: NSRange) -> String {
        guard self.range.contains(range) else { return "" }
        return self*.substringWithRange(range)
    }
    
}

// MARK: - ** String Paragraph Ranges **

extension String {
    
    ///
    public func paragraphRangeForRange(range: IntRange) -> NSRange {
        return self*.paragraphRangeForRange(range*)
    }
    
    ///
    public func paragraphRangeForRange(range: NSRange) -> NSRange {
        guard self.range.contains(range) else { return range }
        return self*.paragraphRangeForRange(range)
    }
    
}

// MARK: - ** String Substring Enumeration **

extension String {
    
    ///
    public func enumerateSubstringsInRange(range: NSRange, options opts: NSStringEnumerationOptions, usingBlock block: (String?, NSRange, NSRange, UnsafeMutablePointer<ObjCBool>) -> Void) {
        self*.enumerateSubstringsInRange(range, options: opts, usingBlock: block)
    }
    
    ///
    public func enumerateSubstringsInRange(range: IntRange, options opts: NSStringEnumerationOptions, usingBlock block: (String?, NSRange, NSRange, UnsafeMutablePointer<ObjCBool>) -> Void) {
        self*.enumerateSubstringsInRange(range*, options: opts, usingBlock: block)
    }
    
}

// MARK: - ** String Substring Replacement **

extension String {
    
    ///
    public func stringByReplacingOccurrencesOfString(string: String, withString: String, options: NSStringCompareOptions, range: NSRange) -> String {
        return self*.stringByReplacingOccurrencesOfString(string, withString: withString, options: options, range: range)
    }
    
}

// MARK: - ** String Exploding **

extension String {

    ///
    public func componentsSeparatedByPattern(pattern: String, template: String = "««") -> [String] {
        guard let expr = try? NSRegularExpression(pattern: pattern, options: []) else { return [] }
        let string = NSMutableString(string: self)
        expr.replaceMatchesInString(string, options: [.WithTransparentBounds], range: string.range, withTemplate: template)
        return string.componentsSeparatedByString(template)
    }
    
}

// MARK: - ** String Escaping **

extension String {
    
    ///
    public var withoutEscapes: String {
        let str = NSMutableString(string: self)
        if let expr = try? NSRegularExpression(pattern: "\\\\([:\\-.*\\^$!?(){}\\[\\]])", options: []) {
            expr.replaceMatchesInString(str, options: [.WithTransparentBounds], range: str.range, withTemplate: "$1")
        }
        if let expr = try? NSRegularExpression(pattern: "\\(\\?\\<\\=.*?\\)", options: []) {
            expr.replaceMatchesInString(str, options: [.WithTransparentBounds], range: str.range, withTemplate: "")
        }
        if let expr = try? NSRegularExpression(pattern: "\\(\\?\\!.*?\\)", options: []) {
            expr.replaceMatchesInString(str, options: [.WithTransparentBounds], range: str.range, withTemplate: "")
        }
        return str as String
    }
    
    /// Generates a regular expression from `self` that would match `self`
    /// by escaping regular expression characters.
    public var regexPattern: String {
        let pattern = NSMutableString(string: self)
        let expr = try! NSRegularExpression(pattern: "([\\{\\}\\(\\)\\[\\]\\*\\|\\.\\:\\?\\!\\<\\>\\=\\+\\$\\^])", options: [])
        expr.replaceMatchesInString(pattern, options: [], range: pattern.range, withTemplate: "\\\\$1")
        return pattern as String
    }
    
}

// MARK: - ** String (General Convenience Extensions) **

extension String {

    ///
    public var leadingWhitespaces: String {
        guard let expr = try? NSRegularExpression(pattern: "[ \\t]*", options: []) else { return "" }
        guard let match = expr.firstMatchInString(self, options: [], range: range) else { return "" }
        if match.range.location != 0 { return "" }
        return self.substringWithRange(match.range) ?? ""
    }
    
}

// MARK: - ** String (General Convenience Extensions) **

extension String {
    
    ///
    public func rangeOfString(string: String, options: NSStringCompareOptions, range: NSRange) -> NSRange? {
        let foundRange = self*.rangeOfString(string, options: options, range: range)
        if foundRange.location == NSNotFound { return nil }
        return foundRange
    }
    
}

// MARK: - ** String (General Convenience Extensions) **

extension String {

    ///
    public func boolValue() -> Bool? {
        switch self {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return nil
        }
    }
    
}

// MARK: - ** String (General Convenience Extensions) **

extension String {

    ///
    public var stringByDeletingLastPathComponent: String {
        return self*.stringByDeletingLastPathComponent
    }

    ///
    public var stringByDeletingPathExtension: String {
        return self*.stringByDeletingPathExtension
    }
    
    ///
    public var stringByRemovingPathDelimiters: String {
        return stringByReplacingOccurrencesOfString("/", withString: "")
    }
    
}

// MARK: - ** String (General Convenience Extensions) **

extension String {

    ///
    public var asURL: NSURL {
        return NSURL(fileURLWithPath: self)
    }
    
}

// MARK: - ** String (General Convenience Extensions) **

extension String {

    ///
    /// - parameter path: The path component to append
    /// - returns: A path string with the appended path component adding slashes where necessary
    public func stringByAppendingPathComponent(path: String) -> String {
        return self*.stringByAppendingPathComponent(path)
    }

    ///
    /// - parameter ext: The extension to append
    /// - returns: A path string with the appended extension
    public func stringByAppendingPathExtension(ext: String) -> String? {
        return self*.stringByAppendingPathExtension(ext)
    }
    
}

// MARK: - ** String (General Convenience Extensions) **

extension String {
    
    /// Formats the string taking any number of arguments and interpolating 
    /// their values.
    /// - parameter format: the arguments to interpolate into this string
    /// - returns: An interpolated string
    public func format(format: CVarArgType...) -> String {
        return (String(format: self, arguments: format))
    }
    
}

// MARK: - ** String (General Convenience Extensions) **

extension String {

    // MARK: Dimension Methods
    
    /// 
    public func sizeWithAttributes(attrs: PropertyList) -> CGSize {
        return self*.sizeWithAttributes(attrs)
    }

    /// 
    /// - parameter height: The constrained height of the drawing bounds
    /// - parameter attrs: The attributes to apply to the string
    /// - returns: Width
    public func width(whenConstrainedToHeight height: CGFloat = .max, withAttributes attrs: PropertyList? = nil) -> CGFloat {
        let attrs = attrs ?? [NSFontAttributeName : UIFont.systemFont()]
        let constraintRect = CGSize(width: height, height: .max)
        let boundingBox = self*.boundingRectWithSize(constraintRect, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attrs, context: nil)
        return boundingBox.width
    }

    /// 
    /// - parameter width: The constrained width of the drawing bounds
    /// - parameter font: The font to apply to the string
    /// - returns: Height
    public func height(whenConstrainedToWidth width: CGFloat = .max, withAttributes attrs: PropertyList? = nil) -> CGFloat {
        let attrs = attrs ?? [NSFontAttributeName : UIFont.systemFont()]
        let constraintRect = CGSize(width: width, height: .max)
        let boundingBox = self*.boundingRectWithSize(constraintRect, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attrs, context: nil)
        return boundingBox.height
    }

}

// MARK: - ** String (General Convenience Extensions) **

extension String {
    
    /// 
    public func stringByReplacingCharactersInRange(range: NSRange, withString string: String) -> String {
        return self*.stringByReplacingCharactersInRange(range, withString: string)
    }
    
    /// 
    public mutating func replaceRange(range: NSRange, withString string: String) {
        self = self.stringByReplacingCharactersInRange(range, withString: string)
    }
    
}

// MARK: - ** String (General Convenience Extensions) **

extension String {
    
    /// 
    public func asImageWithAttributes(attrs: PropertyList, withSize size: CGSize? = nil) -> UIImage {

        let size = size ?? self.sizeWithAttributes(attrs)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0);
        
        // draw in context, you can use also drawInRect:withFont:
        self*.drawAtPoint(CGPointMake(0.0, 0.0), withAttributes: attrs)
        
        // transfer image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()  
        
        return image
        
    }
    
    /// 
    public func imageWithSize(size: CGSize) -> UIImage {
    
        let font = UIFont.systemFont()  
        let size = self*.boundingRectWithSize(size, options: [], attributes: [NSFontAttributeName : font], context: nil).size
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0);
        
        // draw in context, you can use also drawInRect:withFont:
        self*.drawAtPoint(CGPointMake(0.0, 0.0), withAttributes: [NSFontAttributeName : font])
        
        // transfer image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()  
        
        return image
    
    }
    
}

// MARK: - ** String (General Convenience Extensions) **

extension String {
    
    /// Alias for `containsString`
    public func contains(other: String) -> Bool {
        return containsString(other)
    }
    
}

// MARK: - ** String (General Convenience Extensions) **

extension String {
    
    /// Determines if a file exists at the path `self`.
    public func fileExists() -> Bool {
        return NSFileManager.defaultManager().fileExistsAtPath(self)
    }
    
}

// MARK: - ** String (General Convenience Extensions) **

extension String {
    
    /// Replaces all occurrences of `target` in `self` with `replacement`.
    /// - parameter target: The string to search for.
    /// - parameter replacement: The string used to replace `target` with.
    public mutating func replaceOccurrencesOfString(target: String, withString replacement: String) {
        self = self.stringByReplacingOccurrencesOfString(target, withString: replacement)
    }
    
}

// MARK: - ** Localization **

extension String {
    
    /// Returns `self` with only the first character captialized.
    public var properString: String {
        let first = String(characters.prefix(1)).uppercaseString
        let other = String(characters.dropFirst())
        return first + other
    }
    
    /// 
    public var localizedString: String {
        return NSLocalizedString(self, comment: "")
    }
    
    /// 
    public var capitalizedLocalizedString: String {
        return localizedString.capitalizedString
    }
    
    /// 
    public var properLocalizedString: String {
        return localizedString.properString
    }
    
    /// 
    public static func pluralize(string: String, _ count: Int) -> String {
        return String.localizedStringWithFormat(NSLocalizedString(string, comment: ""), count)
    }
    
    /// 
    public static func pluralize(string: String, _ count: Double) -> String {
        return String.localizedStringWithFormat(NSLocalizedString(string, comment: ""), count)
    }
    
    /// 
    public static func pluralize(string: String, _ count: Float) -> String {
        return String.localizedStringWithFormat(NSLocalizedString(string, comment: ""), count)
    }    
    
    /// 
    public static func capitalizedLocalizedString(key: String) -> String {
        let str = NSLocalizedString(key, comment: "")
        return str.capitalizedLocalizedString
    }
    
}

// MARK: - ** String Extension (Regular Expression) **

extension String {
    
    /// 
    public var shortestRegexMatch: String {
        
        let pattern = NSMutableString(string: self)
        
        if let expr = try? NSRegularExpression(pattern: "(\\\\[b])|(\\(\\?(:|<=|<!|=|!).*?\\))", options: []) {
            expr.replaceMatchesInString(pattern, options: [], range: pattern.range, withTemplate: "")
        }
        
        if let expr = try? NSRegularExpression(pattern: "(\\\\[swBSW])", options: []) {
            expr.replaceMatchesInString(pattern, options: [], range: pattern.range, withTemplate: ".")
        }
        
        if let expr = try? NSRegularExpression(pattern: "\\\\[?!(){}^$*:|[=\\]]", options: []) {
            var match = expr.firstMatchInString(pattern as String, options: [], range: pattern.range)
            while match != nil {
                pattern.replaceCharactersInRange(match!.range, withString: pattern.substringWithRange(NSMakeRange(match!.range.location + 1, 1)))
                match = expr.firstMatchInString(pattern as String, options: [], range: pattern.range)
            }
        }
        
        if let expr = try? NSRegularExpression(pattern: "\\(\\?\\=\\(((\\\\\\()|[^(])*\\)", options: []) {
            var match = expr.firstMatchInString(pattern as String, options: [], range: pattern.range)
            while match != nil {
                pattern.replaceCharactersInRange(match!.range, withString: "")
                match = expr.firstMatchInString(pattern as String, options: [], range: pattern.range)
            }
        }
        
        if let expr = try? NSRegularExpression(pattern: "(\\((\\\\\\(|[^(])*\\)|\\[(\\\\\\[|[^[])*\\]|.)[*?]", options: []) {
            var match = expr.firstMatchInString(pattern as String, options: [], range: pattern.range)
            while match != nil {
                pattern.replaceCharactersInRange(match!.range, withString: "")
                match = expr.firstMatchInString(pattern as String, options: [], range: pattern.range)
            }
        }
        
        if let expr = try? NSRegularExpression(pattern: "(\\[(\\\\\\[|[^[])*\\]|.)[+]", options: []) {
            var match = expr.firstMatchInString(pattern as String, options: [], range: pattern.range)
            while match != nil {
                pattern.replaceCharactersInRange(match!.range, withString: ".")
                match = expr.firstMatchInString(pattern as String, options: [], range: pattern.range)
            }
        }
        
        if let expr = try? NSRegularExpression(pattern: "(\\((\\\\\\(|[^(])*\\)[+]", options: []) {
            expr.replaceMatchesInString(pattern, options: [], range: pattern.range, withTemplate: "$1")
        }
        
        if let expr = try? NSRegularExpression(pattern: "\\{[0-9]*,.*?\\}", options: []) {
            var match = expr.firstMatchInString(pattern as String, options: [], range: pattern.range)
            while match != nil {
                pattern.replaceCharactersInRange(match!.range, withString: "")
                match = expr.firstMatchInString(pattern as String, options: [], range: pattern.range)
            }
        }
        
        if let expr = try? NSRegularExpression(pattern: "\\((\\\\\\(|[^(])*\\)", options: []) {
            
            var result = expr.firstMatchInString(pattern as String, options: [], range: pattern.range)
            while result != nil {
                let substring = pattern.substringWithRange(NSMakeRange(result!.range.location + 1, result!.range.length - 2))
                var word = substring
                let multiplicity = 1
                for string in substring.componentsSeparatedByString("|") {
                    if string.length < word.length  {
                        word = string
                    }
                }
                pattern.replaceCharactersInRange(result!.range, withString: word * multiplicity)
                result = expr.firstMatchInString(pattern as String, options: [], range: pattern.range)
            }
            
        }
        
        return pattern as String
        
    }
    
    /// 
    public var minRegexMatchLength: Int {
        return shortestRegexMatch.length
    }
    
}




