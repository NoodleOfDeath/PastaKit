//
// NSParagraphStyle.swift
// NoodleBox
//
// Created by NoodleOfDeath on 3/6/16.
// Copyright © 2016 NoodleNation. All rights reserved.
//

import UIKit

// MARK: - ** NSParagraphStyle Extension **
extension NSParagraphStyle {

    /// Provide a preset [NSMutableParagraphStyle](xdoc://) instance with a specific tab span
    /// - parameter tabSpan: Character width of tab characters (default is 4)
    /// - parameter attrs: The contextual font attributes for which to determine character width
    /// - parameter strReference: Character used to determine a single character width
    /// - returns: A [NSMutableParagraphStyle](xdoc://) instance with a tab span of `tabSpan` based on font with attributes `attrs`
    open static func mutableStyle(_ tabWidth: Int = 4, attributes attrs: [String: Any] = [NSFontAttributeName: UIFont.systemFont()], strReference: String = "A") -> NSMutableParagraphStyle {
        let paragraphStyle = `default`.mutableCopy() as! NSMutableParagraphStyle
        let charWidth = strReference.width(withAttributes: attrs)
        paragraphStyle.defaultTabInterval = charWidth * CGFloat(tabWidth)
        paragraphStyle.tabStops = nil
        return paragraphStyle
    }

}
