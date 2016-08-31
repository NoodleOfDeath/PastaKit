//
//  NSString.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 8/18/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import Foundation

extension NSString {
    
    /// The range representation of this string.
    public var range: NSRange {
        return NSMakeRange(0, length)
    }
    
}