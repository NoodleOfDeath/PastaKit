//
//  UITableView.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 6/10/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import UIKit

public let UITableViewCellDefaultReuseIdentifier = "UITableViewCellDefaultReuseIdentifier"

public protocol StringEnumeration {
    var rawValue: String { get }
}

extension UITableView {
    
    /// Convenience initializer that omits the initial frame parameter. The
    /// frame is set to `CGRectZero` initially.
    /// - parameter style: A constant that specifies the style of the table 
    /// view. See Table View Style for descriptions of valid constants.
    /// - returns: Returns an initialized `UITableView` object, or `nil` if 
    /// the object could not be successfully initialized.
    public convenience init(style: UITableViewStyle) {
        self.init(frame: CGRect.zero, style: style)
    }
    
    /// Registers a class for use in creating new table cells.
    /// 
    /// Prior to dequeueing any cells, call this method or the register(_:forCellReuseIdentifier:) method to tell the table view how to create new cells. If a cell of the specified type is not currently in a reuse queue, the table view uses the provided information to create a new cell object automatically.
    /// 
    /// If you previously registered a class or nib file with the same reuse identifier, the class you specify in the cellClass parameter replaces the old entry. You may specify nil for cellClass if you want to unregister the class from the specified reuse identifier.
    ///
    /// - parameter cellClass: The class of a cell that you want to use in the table.
    /// - parameter identifier: The reuse identifier for the cell. This parameter must not be nil and must not be an empty string.
    open func register(_ cellClass: Swift.AnyClass?, forCellReuseIdentifier identifier: StringEnumeration) {
        register(cellClass, forCellReuseIdentifier: identifier.rawValue)
    }
    
}
