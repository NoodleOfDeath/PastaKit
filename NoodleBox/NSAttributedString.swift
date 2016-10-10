//
//  NSAttributedString.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 6/11/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import Foundation

// MARK: - ** NSAttributedString Extension (General Convenience) **

/// Convenience get-only properties and methods for the
/// `NSAttributedString` public class.
extension NSAttributedString {
    
    ///  The range representation of this string.
    ///  - returns: `NSMakeRange(0, length)`
    public var range: NSRange {
        return NSMakeRange(0, length)
    }
    
    /// The width of the leading whitespaces that offset this string.
    public var leadingIndentation: CGFloat {
        return attributedSubstring(from: NSMakeRange(0, string.leadingWhitespaces.length)).size().width
    }
    
    /// The width this string would attain is the drawing bounds were constrainted
    /// to a maximum height.
    /// - parameter height: The maximum height to constrain the drawing bounds in.
    /// - returns: The width this string would attain is the drawing bounds were
    /// constrainted to a maximum height of `height`.
    public func width(whenConstrainedToHeight height: CGFloat = .greatestFiniteMagnitude) -> CGFloat {
        let size = CGSize(width: .greatestFiniteMagnitude, height: height)
        let rect = boundingRect(with: size, options: .usesLineFragmentOrigin, context: nil)
        return ceil(rect.size.width)
    }
    
    /// The height this string would attain is the drawing bounds were constrainted
    /// to a maximum width.
    /// - parameter width: The maximum width to constrain the drawing bounds in.
    /// - returns: The height this string would attain is the drawing bounds were
    /// constrainted to a maximum width of `width`.
    public func height(whenConstrainedToWidth width: CGFloat = .greatestFiniteMagnitude) -> CGFloat {
        let size = CGSize(width: width, height: .greatestFiniteMagnitude)
        let rect = boundingRect(with: size, options: .usesLineFragmentOrigin, context: nil)
        return ceil(rect.height)
    }
    
}

