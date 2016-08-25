//
//  UITextInput.swift
//  NoodleBox
//
//  Created by Thom Morgan on 7/22/16.
//  Copyright © 2016 NoodleOfDeath. All rights reserved.
//

import UIKit
import Foundation

extension UITextInput {
    
    // MARK: - ** Protocol Methods **
    
    // MARK: - UIKeyboardInput
    
    public func keyboardInputShouldDelete(textView: UITextView) -> Bool {
        
        var shouldDelete = true
        
        if UITextView.instancesRespondToSelector(#function) {
            let op = UITextView.instanceMethodForSelector(#function)
            let mp = UnsafeMutablePointer<(delegate: AnyObject, selector: Selector, textView: UITextView) -> Bool>(op)
            let keyboardInputShouldDelete = mp.memory
            shouldDelete = keyboardInputShouldDelete(delegate: self, selector: #function, textView: textView)
        }
        
        let isIOS8 = Int(UIDevice.currentDevice().systemVersion) == 8
        let isLtIOS8_3 = Float(UIDevice.currentDevice().systemVersion) < 8.3
        
        if textView.text.length > 0 && isIOS8 && isLtIOS8_3 {
            deleteBackward()
        }
        
        return shouldDelete
        
    }
    
    public func deleteForward() {
        guard let selectedTextRange = selectedTextRange else { return }
        if !selectedTextRange.empty {
            deleteBackward()
            return
        }
        let start = offsetFromPosition(beginningOfDocument, toPosition: selectedTextRange.start)
        let length = offsetFromPosition(selectedTextRange.start, toPosition: endOfDocument)
        if !(length > 0) { return }
        guard let range = textRangeOfRange(NSMakeRange(start, 1)) else { return }
        replaceRange(range, withText: "")
    }
    
    // MARK: - ** Public Methods **
    
    // MARK: -
    
    @available(iOS 3.2, *)
    public func locationOfTextPosition(textPosition: UITextPosition) -> Int {
        return offsetFromPosition(beginningOfDocument, toPosition: textPosition)
    }
    
    @available(iOS 3.2, *)
    public func rangeOfTextRange(textRange: UITextRange) -> NSRange {
        let loc = locationOfTextPosition(textRange.start)
        let end = locationOfTextPosition(textRange.end)
        return NSMakeRange(loc, end - loc)
    }
    
    @available(iOS 3.2, *)
    public func textPositionOfLocation(location: Int) -> UITextPosition? {
        return positionFromPosition(beginningOfDocument, offset: location)
    }
    
    @available(iOS 3.2, *)
    public func textRangeOfRange(range: NSRange) -> UITextRange? {
        guard let start = textPositionOfLocation(range.location) else { return nil }
        guard let end = positionFromPosition(start, offset: range.length) else { return nil }
        return textRangeFromPosition(start, toPosition: end)
    }
    
}