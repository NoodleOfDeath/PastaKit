//
//  UITextInput.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 7/22/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import UIKit
import Foundation
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}


extension UITextInput {
    
    // MARK: - ** Protocol Methods **
    
    // MARK: - UIKeyboardInput
    
    public func keyboardInputShouldDelete(_ textView: UITextView) -> Bool {
        
        var shouldDelete = true
        
        if UITextView.instancesRespond(to: #function) {
            let op = UITextView.instanceMethod(for: #function)
            let mp = UnsafeMutablePointer<(_ delegate: AnyObject, _ selector: Selector, _ textView: UITextView) -> Bool>(op)
            let keyboardInputShouldDelete = mp?.pointee
            shouldDelete = keyboardInputShouldDelete(delegate: self, selector: #function, textView: textView)
        }
        
        let isIOS8 = Int(UIDevice.current.systemVersion) == 8
        let isLtIOS8_3 = Float(UIDevice.current.systemVersion) < 8.3
        
        if textView.text.length > 0 && isIOS8 && isLtIOS8_3 {
            deleteBackward()
        }
        
        return shouldDelete
        
    }
    
    public func deleteForward() {
        guard let selectedTextRange = selectedTextRange else { return }
        if !selectedTextRange.isEmpty {
            deleteBackward()
            return
        }
        let start = offset(from: beginningOfDocument, to: selectedTextRange.start)
        let length = offset(from: selectedTextRange.start, to: endOfDocument)
        if !(length > 0) { return }
        guard let range = textRangeOfRange(NSMakeRange(start, 1)) else { return }
        replace(range, withText: "")
    }
    
    // MARK: - ** Public Methods **
    
    // MARK: -
    
    @available(iOS 3.2, *)
    public func locationOfTextPosition(_ textPosition: UITextPosition) -> Int {
        return offset(from: beginningOfDocument, to: textPosition)
    }
    
    @available(iOS 3.2, *)
    public func rangeOfTextRange(_ textRange: UITextRange) -> NSRange {
        let loc = locationOfTextPosition(textRange.start)
        let end = locationOfTextPosition(textRange.end)
        return NSMakeRange(loc, end - loc)
    }
    
    @available(iOS 3.2, *)
    public func textPositionOfLocation(_ location: Int) -> UITextPosition? {
        return position(from: beginningOfDocument, offset: location)
    }
    
    @available(iOS 3.2, *)
    public func textRangeOfRange(_ range: NSRange) -> UITextRange? {
        guard let start = textPositionOfLocation(range.location) else { return nil }
        guard let end = position(from: start, offset: range.length) else { return nil }
        return textRange(from: start, to: end)
    }
    
}
