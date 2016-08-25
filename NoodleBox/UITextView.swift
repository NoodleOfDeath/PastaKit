//
//
//
//

import UIKit

public protocol UIKeyboardInput : NSObjectProtocol {
    func keyboardInputShouldDelete(textView: UITextView) -> Bool
}

extension UITextView : UIKeyboardInput {}

extension UITextView {
    
    public var selectedParagraphRange: NSRange {
        return paragraphRangeForRange(selectedRange)
    }
    
    public var visibleRange: NSRange? {
        if let start = closestPositionToPoint(contentOffset) {
            if let end = characterRangeAtPoint(CGPointMake(contentOffset.x + CGRectGetMaxX(bounds), contentOffset.y + CGRectGetMaxY(bounds)))?.end {
                return NSMakeRange(offsetFromPosition(beginningOfDocument, toPosition: start), offsetFromPosition(start, toPosition: end))
            }
        }
        return nil
    }

    public var rangeOfPrecedingWord: NSRange? {
        return rangeOfPrecedingWordWithAcceptableCharacters("@#$&\\-")
    }

    public var precedingWord: String? {
        guard let range = rangeOfPrecedingWord else { return nil }
        guard text.range.contains(range) else { return nil }
        return substringWithRange(range)
    }
    
    public var precedingCharacter: String {
        return precedingCharacters(1)
    }
    
    public var procedingCharacter: String {
        return procedingCharacters(1)
    }
    
    public var locationOfNextNonWhitespaceCharacter: Int {
        guard let expr = try? NSRegularExpression(pattern: "\\S", options: []) else { return NSNotFound }
        guard let match = expr.firstMatchInString(text, options: [], range: NSMakeRange(selectedRange.location, text.length - selectedRange.location)) else { return NSNotFound }
        return match.range.location
    }
    
    public var nextNonWhitespaceCharacter: String? {
        return locationOfNextNonWhitespaceCharacter != NSNotFound ? text.substringWithRange(NSMakeRange(locationOfNextNonWhitespaceCharacter, 1)) : nil
    }
    
    // MARK: - ** Protocol Methods **
    
    // MARK: - Public Methods
    
    public func substringWithRange(range: NSRange) -> String {
        return text.substringWithRange(range) ?? ""
    }
    
    public func paragraphRangeForRange(range: NSRange) -> NSRange {
        return text.paragraphRangeForRange(range)
    }
    
    @available(iOS 4.0, *)
    public func enumerateSubstringsInRange(range: NSRange, options opts: NSStringEnumerationOptions, usingBlock block: (String?, NSRange, NSRange, UnsafeMutablePointer<ObjCBool>) -> Void) {
        text.enumerateSubstringsInRange(range, options: opts, usingBlock: block)
    }
    
    // MARK: -
    
    public func boundingRectForCharacterRange(range: NSRange) -> CGRect {
        var glyphRange = NSRange()
        layoutManager.characterRangeForGlyphRange(range, actualGlyphRange: &glyphRange)
        return layoutManager.boundingRectForGlyphRange(range, inTextContainer: textContainer)
    }
    
    // MARK: -
    
    public func invalidateCharacterDisplayAndLayout() {
        invalidateCharacterDisplayAndLayoutForCharacterRange(text.range)
    }
    
    public func invalidateCharacterDisplayAndLayoutForCharacterRange(range: NSRange) {
        let range = text.range.contains(range) ? range : text.range
        layoutManager.invalidateDisplayForCharacterRange(range)
        layoutManager.invalidateLayoutForCharacterRange(range, actualCharacterRange: nil)
    }
    
    public func undo() {
        undoManager?.undo()
    }
    
    public func redo() {
        undoManager?.redo()
    }
    
    public func rangeOfPrecedingWordWithAcceptableCharacters(characters: String) -> NSRange? {
        guard let expr = try? NSRegularExpression(pattern: "[\\w\(characters)]+$", options: []) else { return nil }
        let paragraphRange = paragraphRangeForRange(selectedRange)
        let searchRange = NSMakeRange(paragraphRange.location, selectedRange.location - paragraphRange.location)
        guard let match = expr.firstMatchInString(text, options: [.WithTransparentBounds], range: searchRange) else { return nil }
        return match.range
    }
    
    public func precedingCharacters(length: Int) -> String {
        if text.length < length { return "" }
        return selectedRange.location > length ?
            text.substringWithRange(NSMakeRange(selectedRange.location - length, length)) :
            text.substringWithRange(NSMakeRange(0, length - selectedRange.location))
    }
    
    public func procedingCharacters(length: Int) -> String {
        if text.length < selectedRange.location + length { return "" }
        return selectedRange.location + length <= text.length ?
            text.substringWithRange(NSMakeRange(selectedRange.location, length)) :
            text.substringWithRange(NSMakeRange(selectedRange.location, text.length - selectedRange.location))
    }
    
    public func precedingCharactersContainString(string: String) -> Bool {
        guard let expr = try? NSRegularExpression(pattern: string + "$", options: []) else { return false }
        let paragraphRange = paragraphRangeForRange(selectedRange)
        let searchRange = NSMakeRange(paragraphRange.location, selectedRange.location - paragraphRange.location)
        if let _ = expr.firstMatchInString(text, options: [.WithTransparentBounds], range: searchRange) {
            return true
        }
        return false
    }
    
    public func precedingCharactersContainString(string: String, inout range: NSRange) -> Bool {
        guard let expr = try? NSRegularExpression(pattern: string + "$", options: []) else { return false }
        let paragraphRange = paragraphRangeForRange(selectedRange)
        let searchRange = NSMakeRange(paragraphRange.location, selectedRange.location - paragraphRange.location)
        if let match = expr.firstMatchInString(text, options: [.WithTransparentBounds], range: searchRange) {
            range = match.range
            return true
        }
        return false
    }
    
    public func procedingCharactersContainString(string: String) -> Bool {
        guard let expr = try? NSRegularExpression(pattern: "^" + string, options: []) else { return false }
        let searchRange = NSMakeRange(selectedRange.location, text.length - selectedRange.location)
        if let _ = expr.firstMatchInString(text, options: [.WithTransparentBounds], range: searchRange) {
            return true
        }
        return false
    }
    
    public func procedingCharactersContainString(string: String, inout range: NSRange) -> Bool {
        guard let expr = try? NSRegularExpression(pattern: "^" + string, options: []) else { return false }
        let searchRange = NSMakeRange(selectedRange.location, text.length - selectedRange.location)
        if let match = expr.firstMatchInString(text, options: [.WithTransparentBounds], range: searchRange) {
            range = match.range
            return true
        }
        return false
    }

}