//
//  UILabel.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 6/9/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import UIKit

extension UILabel {
    
    public convenience init(text: String?) {
        self.init()
        self.text = text
    }
    
    open func boundingRectForCharacterRange(_ range: NSRange) -> CGRect? {
        
        guard let attributedText = attributedText else { return nil }
        
        let textStorage = NSTextStorage(attributedString: attributedText)
        let layoutManager = NSLayoutManager()
        
        textStorage.addLayoutManager(layoutManager)
        
        let textContainer = NSTextContainer(size: bounds.size)
        textContainer.widthTracksTextView = true
        textContainer.heightTracksTextView = true
        textContainer.lineBreakMode = lineBreakMode
        textContainer.lineFragmentPadding = 0
        
        layoutManager.addTextContainer(textContainer)
        
        let textView = UITextView(frame: frame, textContainer: textContainer)
        
        return textView.boundingRectForCharacterRange(range)
        
    }
    
}
