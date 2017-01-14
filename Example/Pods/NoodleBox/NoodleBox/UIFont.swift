//
// UIFont.swift
// NoodleBox
//
// Created by NoodleOfDeath on 3/8/16.
// Copyright © 2016 NoodleNation. All rights reserved.
//

import UIKit

public let CTFontFamily = "CTFontFamily"
public let CTFontSize = "CTFontSize"

// MARK: - ** UIFont Extension **

extension UIFont {

    /// Returns the font object used for standard interface items in the size of the standard system font.
    /// A font object of the standard system font and size.
    /// - returns: A font object of the standard system font and size.
    open static func systemFont() -> UIFont {
        return self.systemFont(ofSize: systemFontSize)
    }

    /// 
    open static func fontWith(_ any: Any, size: CGFloat = UIFont.systemFontSize) -> UIFont? {
        
        switch any {
            
        case let any as UIFont:
            return any
            
        case let any as [String : Any]:
            guard let family = any[CTFontFamily] as? String else { return nil }
            let size = any[CTFontSize] as? CGFloat ?? size
            return UIFont(name: family, size: size)
            
        default:
            break
            
        }
        
        return nil
        
    }

}
