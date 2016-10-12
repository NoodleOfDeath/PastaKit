//
//  UIBarButtonItem.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 3/12/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import UIKit

// MARK: - ** UIBarButtonItem Extension **
extension UIBarButtonItem {

    public convenience init(title: String?, target: Any? = nil, action: Selector? = nil) {
        self.init(title: title, style: .plain, target: target, action: action)
    }

    public convenience init(image: UIImage?, target: Any? = nil, action: Selector? = nil) {
        self.init(image: image, style: .plain, target: target, action: action)
    }

    ///     A standard fixed space [UIBarButtonItem]() of specified width
    /// - parameter width: The fixed width of to make the space
    /// - returns: A fixed space instance with a width of `width`
    open static func fixedSpace(_ width: CGFloat = 0.0) -> UIBarButtonItem {
        let item = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        item.width = width
        return item
    }

    ///     A standard flexible space [UIBarButtonItem]()
    /// - returns: A flexible space instance
    open static func flexibleSpace() -> UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    }

}
