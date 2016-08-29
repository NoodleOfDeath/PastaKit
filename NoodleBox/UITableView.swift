//
//  UITableView.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 6/10/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import UIKit

public let UITableViewCellDefaultReuseIdentifier = "UITableViewCellDefaultReuseIdentifier"

extension UITableView {
    
    /// Convenience initializer that omits the initial frame parameter. The
    /// frame is set to `CGRectZero` initially.
    /// - parameter style: A constant that specifies the style of the table 
    /// view. See Table View Style for descriptions of valid constants.
    /// - returns: Returns an initialized `UITableView` object, or `nil` if 
    /// the object could not be successfully initialized.
    public convenience init(style: UITableViewStyle) {
        self.init(frame: CGRectZero, style: style)
    }
    
}
