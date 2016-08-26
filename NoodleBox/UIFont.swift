//
//  UIFont.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 3/8/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import UIKit

public let CTFontFamily = "CTFontFamily"
public let CTFontSize = "CTFontSize"

// MARK: - ** UIFont Extension **
extension UIFont {

    /**
    returns the font object used for standard interface items in the size of the standard system font.

    A font object of the standard system font and size

    - returns: A font object of the standard system font and size
    */
    public static func systemFont() -> UIFont {
        return systemFontOfSize(systemFontSize())
    }

    public static func fontWithObject(obj: AnyObject, size: CGFloat = UIFont.systemFontSize()) -> UIFont? {
        
        if let obj = obj as? UIFont {
            
            return obj
            
        } else if let obj = obj as? PropertyList {
            
            guard let family = obj[CTFontFamily] as? String else { return nil }
            let size = obj[CTFontSize] as? CGFloat ?? size
            
            return UIFont(name: family, size: size)
            
        }
        
        return nil
        
    }

}
