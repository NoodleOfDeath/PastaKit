//
//  NSAttributeName.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 8/23/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import Foundation

/// Convenience structure that contains all of the `NS***AttributeName` string
/// constants
public struct NSAttributeName : OptionSet, Hashable {
    
    public typealias RawValue = Int
    
    public let rawValue: RawValue
    public let stringValue: String
    
    public var hashValue: Int {
        return stringValue.hashValue
    }
    
    // Predefined character attributes for text. If the key is not in the dictionary, then use the default values as described below.
    /************************ Attributes ************************/
    public static let Font = NSAttributeName(NSFontAttributeName)
    public static let ParagraphStyle = NSAttributeName(NSParagraphStyleAttributeName)
    public static let ForegroundColor = NSAttributeName(NSForegroundColorAttributeName)
    public static let BackgroundColor = NSAttributeName(NSBackgroundColorAttributeName)
    public static let Ligature = NSAttributeName(NSLigatureAttributeName)
    public static let Kern = NSAttributeName(NSKernAttributeName)
    public static let StrikethroughStyle = NSAttributeName(NSStrikethroughStyleAttributeName)
    public static let UnderlineStyle = NSAttributeName(NSUnderlineStyleAttributeName)
    public static let StrokeColor = NSAttributeName(NSStrokeColorAttributeName)
    public static let StrokeWidth = NSAttributeName(NSStrokeWidthAttributeName)
    public static let Shadow = NSAttributeName(NSShadowAttributeName)
    public static let TextEffect = NSAttributeName(NSTextEffectAttributeName)

    public static let Attachment = NSAttributeName(NSAttachmentAttributeName)
    public static let Link = NSAttributeName(NSLinkAttributeName)
    public static let BaselineOffset = NSAttributeName(NSBaselineOffsetAttributeName)
    public static let UnderlineColor = NSAttributeName(NSUnderlineColorAttributeName)
    public static let StrikethroughColor = NSAttributeName(NSStrikethroughColorAttributeName)
    public static let Obliqueness = NSAttributeName(NSObliquenessAttributeName)
    public static let Expansion = NSAttributeName(NSExpansionAttributeName)

    public static let WritingDirection = NSAttributeName(NSWritingDirectionAttributeName)

    public static let VerticalGlyphForm = NSAttributeName(NSVerticalGlyphFormAttributeName)
    
    fileprivate static var values: [ RawValue : String ] {
        return [
            Font.hashValue                  : Font.stringValue,
            ParagraphStyle.hashValue        : ParagraphStyle.stringValue,
            ForegroundColor.hashValue       : ForegroundColor.stringValue,
            BackgroundColor.hashValue       : BackgroundColor.stringValue,
            Ligature.hashValue              : Ligature.stringValue,
            Kern.hashValue                  : Kern.stringValue,
            StrikethroughStyle.hashValue    : StrikethroughStyle.stringValue,
            UnderlineStyle.hashValue        : UnderlineStyle.stringValue,
            StrokeColor.hashValue           : StrokeColor.stringValue,
            StrokeWidth.hashValue           : StrokeWidth.stringValue,
            Shadow.hashValue                : Shadow.stringValue,
            TextEffect.hashValue            : TextEffect.stringValue,
            Attachment.hashValue            : Attachment.stringValue,
            Link.hashValue                  : Link.stringValue,
            BaselineOffset.hashValue        : BaselineOffset.stringValue,
            UnderlineColor.hashValue        : UnderlineColor.stringValue,
            StrikethroughColor.hashValue    : StrikethroughColor.stringValue,
            Obliqueness.hashValue           : Obliqueness.stringValue,
            Expansion.hashValue             : Expansion.stringValue,
            WritingDirection.hashValue      : WritingDirection.stringValue,
            VerticalGlyphForm.hashValue     : VerticalGlyphForm.stringValue,
        ]
    }
    
    public init() {
        rawValue = 0
        stringValue = ""
    }
    
    public init(rawValue: RawValue) {
        self.rawValue = rawValue
        stringValue = NSAttributeName.values[rawValue] ?? ""
    }
    
    public init(_ rawValue: RawValue) {
        self.init(rawValue: rawValue)
    }
    
    public init(stringValue: String) {
        rawValue = stringValue.hashValue
        self.stringValue = stringValue
    }
    
    public init(_ stringValue: String) {
        self.init(stringValue: stringValue)
    }
    
    public init(stringValues: [String]) {
        var rawValue: RawValue = 0
        for stringValue in stringValues {
            rawValue += stringValue.hashValue
        }
        self.rawValue = rawValue
        stringValue = stringValues.joined(separator: " ")
    }
    
    public init(_ stringValues: [String]) {
        self.init(stringValues: stringValues)
    }
    
    public func arrayRepresentation() -> [String] {
        return stringValue.components(separatedBy: .whitespaces)
    }

}
