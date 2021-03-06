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

import UIKit

public protocol UIKeyboardInput : NSObjectProtocol {
    func keyboardInputShouldDelete(_ textView: UITextView) -> Bool
}

extension UITextView : UIKeyboardInput {}

extension UITextView {
    
    open var selectedParagraphRange: NSRange {
        return paragraphRangeForRange(selectedRange)
    }
    
    open var visibleRange: NSRange? {
        if let start = closestPosition(to: contentOffset) {
            if let end = characterRange(at: CGPoint(x: contentOffset.x + bounds.maxX, y: contentOffset.y + bounds.maxY))?.end {
                return NSMakeRange(offset(from: beginningOfDocument, to: start), offset(from: start, to: end))
            }
        }
        return nil
    }

    open var rangeOfPrecedingWord: NSRange? {
        return rangeOfPrecedingWordWithAcceptableCharacters("@#$&\\-")
    }

    open var precedingWord: String? {
        guard let range = rangeOfPrecedingWord else { return nil }
        guard text.range.contains(range) else { return nil }
        return substring(with: range)
    }
    
    open var precedingCharacter: String {
        return precedingCharacters(1)
    }
    
    open var procedingCharacter: String {
        return procedingCharacters(1)
    }
    
    open var locationOfNextNonWhitespaceCharacter: Int {
        guard let expr = try? NSRegularExpression(pattern: "\\S", options: []) else { return NSNotFound }
        guard let match = expr.firstMatch(in: text, options: [], range: NSMakeRange(selectedRange.location, text.length - selectedRange.location)) else { return NSNotFound }
        return match.range.location
    }
    
    open var nextNonWhitespaceCharacter: String? {
        return locationOfNextNonWhitespaceCharacter != NSNotFound ? text.substring(with: NSMakeRange(locationOfNextNonWhitespaceCharacter, 1)) : nil
    }
    
    // MARK: - Protocol Methods
    
    // MARK: - Public Methods
    
    open func substring(with range: NSRange) -> String {
        return text.substring(with: range)
    }
    
    open func paragraphRangeForRange(_ range: NSRange) -> NSRange {
        return text.paragraphRange(for: range)
    }
    
    @available(iOS 4.0, *)
    open func enumerateSubstrings(in range: Range<String.Index>, options opts: String.EnumerationOptions, body: @escaping (String?, Range<String.Index>, Range<String.Index>, inout Bool) -> Void) {
        text.enumerateSubstrings(in: range, options: opts, body)
    }
    
    // MARK: -
    
    open func boundingRectForCharacterRange(_ range: NSRange) -> CGRect {
        var glyphRange = NSRange()
        layoutManager.characterRange(forGlyphRange: range, actualGlyphRange: &glyphRange)
        return layoutManager.boundingRect(forGlyphRange: range, in: textContainer)
    }
    
    // MARK: -
    
    open func invalidateCharacterDisplayAndLayout() {
        invalidateCharacterDisplayAndLayoutForCharacterRange(text.range)
    }
    
    open func invalidateCharacterDisplayAndLayoutForCharacterRange(_ range: NSRange) {
        let range = text.range.contains(range) ? range : text.range
        layoutManager.invalidateDisplay(forCharacterRange: range)
        layoutManager.invalidateLayout(forCharacterRange: range, actualCharacterRange: nil)
    }
    
    open func undo() {
        undoManager?.undo()
    }
    
    open func redo() {
        undoManager?.redo()
    }
    
    open func rangeOfPrecedingWordWithAcceptableCharacters(_ characters: String) -> NSRange? {
        guard let expr = try? NSRegularExpression(pattern: "[\\w\(characters)]+$", options: []) else { return nil }
        let paragraphRange = paragraphRangeForRange(selectedRange)
        let searchRange = NSMakeRange(paragraphRange.location, selectedRange.location - paragraphRange.location)
        guard let match = expr.firstMatch(in: text, options: [.withTransparentBounds], range: searchRange) else { return nil }
        return match.range
    }
    
    open func precedingCharacters(_ length: Int) -> String {
        if text.length < length { return "" }
        return selectedRange.location > length ?
            text.substring(with: NSMakeRange(selectedRange.location - length, length)) :
            text.substring(with: NSMakeRange(0, length - selectedRange.location))
    }
    
    open func procedingCharacters(_ length: Int) -> String {
        if text.length < selectedRange.location + length { return "" }
        return selectedRange.location + length <= text.length ?
            text.substring(with: NSMakeRange(selectedRange.location, length)) :
            text.substring(with: NSMakeRange(selectedRange.location, text.length - selectedRange.location))
    }
    
    open func precedingCharactersContainString(_ string: String) -> Bool {
        guard let expr = try? NSRegularExpression(pattern: string + "$", options: []) else { return false }
        let paragraphRange = paragraphRangeForRange(selectedRange)
        let searchRange = NSMakeRange(paragraphRange.location, selectedRange.location - paragraphRange.location)
        if let _ = expr.firstMatch(in: text, options: [.withTransparentBounds], range: searchRange) {
            return true
        }
        return false
    }
    
    open func precedingCharactersContainString(_ string: String, range: inout NSRange) -> Bool {
        guard let expr = try? NSRegularExpression(pattern: string + "$", options: []) else { return false }
        let paragraphRange = paragraphRangeForRange(selectedRange)
        let searchRange = NSMakeRange(paragraphRange.location, selectedRange.location - paragraphRange.location)
        if let match = expr.firstMatch(in: text, options: [.withTransparentBounds], range: searchRange) {
            range = match.range
            return true
        }
        return false
    }
    
    open func procedingCharactersContainString(_ string: String) -> Bool {
        guard let expr = try? NSRegularExpression(pattern: "^" + string, options: []) else { return false }
        let searchRange = NSMakeRange(selectedRange.location, text.length - selectedRange.location)
        if let _ = expr.firstMatch(in: text, options: [.withTransparentBounds], range: searchRange) {
            return true
        }
        return false
    }
    
    open func procedingCharactersContainString(_ string: String, range: inout NSRange) -> Bool {
        guard let expr = try? NSRegularExpression(pattern: "^" + string, options: []) else { return false }
        let searchRange = NSMakeRange(selectedRange.location, text.length - selectedRange.location)
        if let match = expr.firstMatch(in: text, options: [.withTransparentBounds], range: searchRange) {
            range = match.range
            return true
        }
        return false
    }

}
