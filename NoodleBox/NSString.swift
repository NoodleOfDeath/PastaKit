//
//  NSString.swift
//  NoodleBox
//
//  Created by Thom Morgan on 8/18/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation

extension NSString {
    
    /// The range representation of this string.
    public var range: NSRange {
        return NSMakeRange(0, length)
    }
    
}

public func NSLocalizedCapitalizedString(key: String) -> String {
    return String.localizedCapitalizedString(key)
}

extension String {
    
    public var localizedCapitalizedString: String {
        if #available(iOS 9, *) {
            return self~.localizedCapitalizedString
        }
        return capitalizedStringWithLocale(NSLocale.autoupdatingCurrentLocale())
    }
    
    public static func localizedCapitalizedString(key: String) -> String {
        let str = NSLocalizedString(key, comment: "")
        return str.localizedCapitalizedString
    }
    
}