//
//  UIFilterView.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 6/27/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

// MARK: - ** Import Modules **

import UIKit

// MARK: - ** UIFilterView - Overlay UIView Subclass ** -

/// A `UIView` subclass that can overlay any other views, but does not receive
/// any touch events; AKA you can interact with views under/behind this view.
open class UIFilterView: UIView {

    override open func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return nil
    }
    
}
