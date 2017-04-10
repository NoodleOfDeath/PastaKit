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
    
    public func array() -> [String] {
        return stringValue.components(separatedBy: .whitespaces)
    }

}
