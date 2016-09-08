//
//  NSSearchOptions.swift
//  NoodleBox
//
//  Created by Thom Morgan on 9/5/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import Foundation

/// Merges together `NSStringCompareOptions`, `NSRegularExpressionOptions`
/// and `NSMatchingOptions` into one single data structure for one less
/// headache.
public struct NSSearchOptions : OptionSetType, Hashable {
    
    public typealias RawValue = Int
    public let rawValue: RawValue
    
    public var hashValue: Int { return rawValue.hashValue }
    
    /// 
    public var compareOptions: NSStringCompareOptions {
        var options = NSStringCompareOptions()
        for (type, option) in NSSearchOptions.compareOptions {
            guard contains(type) else { continue }
            options.insert(option)
        }
        return options
    }
    
    /// 
    public var expressionOptions: NSRegularExpressionOptions {
        var options = NSRegularExpressionOptions()
        for (type, option) in NSSearchOptions.expressionOptions {
            guard contains(type) else { continue }
            options.insert(option)
        }
        return options
    }
    
    /// 
    public var matchingOptions: NSMatchingOptions {
        var options = NSMatchingOptions()
        for (type, option) in NSSearchOptions.matchingOptions {
            guard contains(type) else { continue }
            options.insert(option)
        }
        return options
    }
    
    public static let RegularExpression = NSSearchOptions(1 << 0)
    
    public static let CaseInsensitive  = NSSearchOptions(1 << 1)
    public static let Literal          = NSSearchOptions(1 << 2)
    public static let Backwards        = NSSearchOptions(1 << 3)
    public static let Anchored         = NSSearchOptions(1 << 4)
    public static let Numeric          = NSSearchOptions(1 << 5)
    
    @available(iOS 2.0, *)
    public static let DiacriticInsensitive   = NSSearchOptions(1 << 6)
    @available(iOS 2.0, *)
    public static let WidthInsensitive       = NSSearchOptions(1 << 7)
    @available(iOS 2.0, *)
    public static let ForcedOrdering         = NSSearchOptions(1 << 8)
    
    public static let AllowCommentsAndWhitespace   = NSSearchOptions(1 << 11)
    public static let IgnoreMetacharacters         = NSSearchOptions(1 << 12)
    public static let DotMatchesLineSeparators     = NSSearchOptions(1 << 13)
    public static let AnchorsMatchLines            = NSSearchOptions(1 << 14)
    public static let UseUnixLineSeparators        = NSSearchOptions(1 << 15)
    public static let UseUnicodeWordBoundaries     = NSSearchOptions(1 << 16)
    
    public static let ReportProgress           = NSSearchOptions(1 << 21)
    public static let ReportCompletion         = NSSearchOptions(1 << 22)
    public static let WithTransparentBounds    = NSSearchOptions(1 << 23)
    public static let WithoutAnchoringBounds   = NSSearchOptions(1 << 24)
    
    private static var compareOptions: [NSSearchOptions : NSStringCompareOptions] {
        return [
            CaseInsensitive         : .CaseInsensitiveSearch,
            Literal                 : .LiteralSearch,
            Backwards               : .BackwardsSearch,
            Anchored                : .AnchoredSearch,
            Numeric                 : .NumericSearch,
            DiacriticInsensitive    : .DiacriticInsensitiveSearch,
            WidthInsensitive        : .WidthInsensitiveSearch,
            ForcedOrdering          : .ForcedOrderingSearch,
            RegularExpression       : .RegularExpressionSearch,
        ]
    }
    
    private static var expressionOptions: [NSSearchOptions : NSRegularExpressionOptions] {
        return [
            CaseInsensitive             : .CaseInsensitive,
            AllowCommentsAndWhitespace  : .AllowCommentsAndWhitespace,
            IgnoreMetacharacters        : .IgnoreMetacharacters,
            DotMatchesLineSeparators    : .DotMatchesLineSeparators,
            AnchorsMatchLines           : .AnchorsMatchLines,
            UseUnixLineSeparators       : .UseUnixLineSeparators,
            UseUnicodeWordBoundaries    : .UseUnicodeWordBoundaries,
        ]
    }
    
    private static var matchingOptions: [NSSearchOptions : NSMatchingOptions] {
        return [
            ReportProgress          : .ReportProgress,
            ReportCompletion        : .ReportCompletion,
            Anchored                : .Anchored,
            WithTransparentBounds   : .WithTransparentBounds,
            WithoutAnchoringBounds  : .WithoutAnchoringBounds,
        ]
    }
    
    static var values: [String : NSSearchOptions] {
        return [
            
            "RegularExpression"     : RegularExpression,
            
            "CaseInsensitive"       : CaseInsensitive,
            "Literal"               : Literal,
            "Backwards"             : Backwards,
            "Anchored"              : Anchored,
            "Numeric"               : Numeric,
            
            "DiacriticInsensitive"  : DiacriticInsensitive,
            "WidthInsensitive"      : WidthInsensitive,
            "ForcedOrdering"        : ForcedOrdering,
            
            "AllowCommentsAndWhitespace"  : AllowCommentsAndWhitespace,
            "IgnoreMetacharacters"        : IgnoreMetacharacters,
            "DotMatchesLineSeparators"    : DotMatchesLineSeparators,
            "AnchorsMatchLines"           : AnchorsMatchLines,
            "UseUnixLineSeparators"       : UseUnixLineSeparators,
            "UseUnicodeWordBoundaries"    : UseUnicodeWordBoundaries,
            
            "ReportProgress"         : ReportProgress,
            "ReportCompletion"       : ReportCompletion,
            "WithTransparentBounds"  : WithTransparentBounds,
            "WithoutAnchoringBounds" : WithoutAnchoringBounds,
            
        ]
    }
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public init(_ rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public init(_ string: String) {
        self.init(string.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceCharacterSet()))
    }
    
    public init(_ strings: [String]) {
        self.init()
        for string in strings {
            guard let value = NSSearchOptions.values[string] else { continue }
            self.insert(value)
        }
    }
    
    public init(_ string: String?) {
        self.init(string?.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceCharacterSet()))
    }
    
    public init(_ strings: [String]?) {
        guard let strings = strings else { self.init(); return }
        self.init(strings)
    }
    
}