//
//  NSMutableAttributedString.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 6/11/16.
//  Copyright © 2016 NoodleOfDeath. All rights reserved.
//

import Foundation

// MARK: - ** NSMutableAttributedString (General Convenience Extensions) **
/**
 NSMutableAttributedString (General Convenience Extensions)
 */
extension NSMutableAttributedString {
    
    public func removeAttributes(attributes: [String], range: NSRange) {
        for attribute in attributes {
            removeAttribute(attribute, range: range)
        }
    }
    
}
