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

extension UITextInput {
    
    // MARK: - ** Protocol Methods **
    
    // MARK: - UIKeyboardInput
    
    public func keyboardInputShouldDelete(_ textView: UITextView) -> Bool {
        
        var shouldDelete = true
        
        if UITextView.instancesRespond(to: #function) {
            let op = UITextView.instanceMethod(for: #function)
            let mp = UnsafeMutablePointer<(_ delegate: Any, _ selector: Selector, _ textView: UITextView) -> Bool>(op)
            guard let keyboardInputShouldDelete = mp?.pointee else { return false }
            shouldDelete = keyboardInputShouldDelete(self, #function, textView)
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
        guard let range = textRange(of: NSMakeRange(start, 1)) else { return }
        replace(range, withText: "")
    }
    
    // MARK: - ** Public Methods **
    
    // MARK: -
    
    @available(iOS 3.2, *)
    public func location(of textPosition: UITextPosition) -> Int {
        return offset(from: beginningOfDocument, to: textPosition)
    }
    
    @available(iOS 3.2, *)
    public func range(of textRange: UITextRange) -> NSRange {
        let loc = location(of: textRange.start)
        let end = location(of: textRange.end)
        return NSMakeRange(loc, end - loc)
    }
    
    @available(iOS 3.2, *)
    public func textPosition(of location: Int) -> UITextPosition? {
        return position(from: beginningOfDocument, offset: location)
    }
    
    @available(iOS 3.2, *)
    public func textRange(of range: NSRange) -> UITextRange? {
        guard let start = textPosition(of: range.location) else { return nil }
        guard let end = position(from: start, offset: range.length) else { return nil }
        return textRange(from: start, to: end)
    }
    
}
