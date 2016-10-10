//
//
//
//

import UIKit

public protocol UIKeyboardInput : NSObjectProtocol {
    func keyboardInputShouldDelete(_ textView: UITextView) -> Bool
}

extension UITextView : UIKeyboardInput {}

extension UITextView {
    
    public var selectedParagraphRange: NSRange {
        return paragraphRangeForRange(selectedRange)
    }
    
    public var visibleRange: NSRange? {
        if let start = closestPosition(to: contentOffset) {
            if let end = characterRange(at: CGPoint(x: contentOffset.x + bounds.maxX, y: contentOffset.y + bounds.maxY))?.end {
                return NSMakeRange(offset(from: beginningOfDocument, to: start), offset(from: start, to: end))
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
        guard let match = expr.firstMatch(in: text, options: [], range: NSMakeRange(selectedRange.location, text.length - selectedRange.location)) else { return NSNotFound }
        return match.range.location
    }
    
    public var nextNonWhitespaceCharacter: String? {
        return locationOfNextNonWhitespaceCharacter != NSNotFound ? text.substringWithRange(NSMakeRange(locationOfNextNonWhitespaceCharacter, 1)) : nil
    }
    
    // MARK: - ** Protocol Methods **
    
    // MARK: - Public Methods
    
    public func substringWithRange(_ range: NSRange) -> String {
        return text.substringWithRange(range) ?? ""
    }
    
    public func paragraphRangeForRange(_ range: NSRange) -> NSRange {
        return text.paragraphRangeForRange(range)
    }
    
    @available(iOS 4.0, *)
    public func enumerateSubstringsInRange(_ range: NSRange, options opts: NSString.EnumerationOptions, usingBlock block: (String?, NSRange, NSRange, UnsafeMutablePointer<ObjCBool>) -> Void) {
        text.enumerateSubstringsInRange(range, options: opts, usingBlock: block)
    }
    
    // MARK: -
    
    public func boundingRectForCharacterRange(_ range: NSRange) -> CGRect {
        var glyphRange = NSRange()
        layoutManager.characterRange(forGlyphRange: range, actualGlyphRange: &glyphRange)
        return layoutManager.boundingRect(forGlyphRange: range, in: textContainer)
    }
    
    // MARK: -
    
    public func invalidateCharacterDisplayAndLayout() {
        invalidateCharacterDisplayAndLayoutForCharacterRange(text.range)
    }
    
    public func invalidateCharacterDisplayAndLayoutForCharacterRange(_ range: NSRange) {
        let range = text.range.contains(range) ? range : text.range
        layoutManager.invalidateDisplay(forCharacterRange: range)
        layoutManager.invalidateLayout(forCharacterRange: range, actualCharacterRange: nil)
    }
    
    public func undo() {
        undoManager?.undo()
    }
    
    public func redo() {
        undoManager?.redo()
    }
    
    public func rangeOfPrecedingWordWithAcceptableCharacters(_ characters: String) -> NSRange? {
        guard let expr = try? NSRegularExpression(pattern: "[\\w\(characters)]+$", options: []) else { return nil }
        let paragraphRange = paragraphRangeForRange(selectedRange)
        let searchRange = NSMakeRange(paragraphRange.location, selectedRange.location - paragraphRange.location)
        guard let match = expr.firstMatch(in: text, options: [.withTransparentBounds], range: searchRange) else { return nil }
        return match.range
    }
    
    public func precedingCharacters(_ length: Int) -> String {
        if text.length < length { return "" }
        return selectedRange.location > length ?
            text.substringWithRange(NSMakeRange(selectedRange.location - length, length)) :
            text.substringWithRange(NSMakeRange(0, length - selectedRange.location))
    }
    
    public func procedingCharacters(_ length: Int) -> String {
        if text.length < selectedRange.location + length { return "" }
        return selectedRange.location + length <= text.length ?
            text.substringWithRange(NSMakeRange(selectedRange.location, length)) :
            text.substringWithRange(NSMakeRange(selectedRange.location, text.length - selectedRange.location))
    }
    
    public func precedingCharactersContainString(_ string: String) -> Bool {
        guard let expr = try? NSRegularExpression(pattern: string + "$", options: []) else { return false }
        let paragraphRange = paragraphRangeForRange(selectedRange)
        let searchRange = NSMakeRange(paragraphRange.location, selectedRange.location - paragraphRange.location)
        if let _ = expr.firstMatch(in: text, options: [.withTransparentBounds], range: searchRange) {
            return true
        }
        return false
    }
    
    public func precedingCharactersContainString(_ string: String, range: inout NSRange) -> Bool {
        guard let expr = try? NSRegularExpression(pattern: string + "$", options: []) else { return false }
        let paragraphRange = paragraphRangeForRange(selectedRange)
        let searchRange = NSMakeRange(paragraphRange.location, selectedRange.location - paragraphRange.location)
        if let match = expr.firstMatch(in: text, options: [.withTransparentBounds], range: searchRange) {
            range = match.range
            return true
        }
        return false
    }
    
    public func procedingCharactersContainString(_ string: String) -> Bool {
        guard let expr = try? NSRegularExpression(pattern: "^" + string, options: []) else { return false }
        let searchRange = NSMakeRange(selectedRange.location, text.length - selectedRange.location)
        if let _ = expr.firstMatch(in: text, options: [.withTransparentBounds], range: searchRange) {
            return true
        }
        return false
    }
    
    public func procedingCharactersContainString(_ string: String, range: inout NSRange) -> Bool {
        guard let expr = try? NSRegularExpression(pattern: "^" + string, options: []) else { return false }
        let searchRange = NSMakeRange(selectedRange.location, text.length - selectedRange.location)
        if let match = expr.firstMatch(in: text, options: [.withTransparentBounds], range: searchRange) {
            range = match.range
            return true
        }
        return false
    }

}
