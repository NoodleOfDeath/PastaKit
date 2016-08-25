//
//  UIFilterView.swift
//  NoodleBox
//
//  Created by Thom Morgan on 6/27/16.
//  Copyright © 2016 NoodleOfDeath. All rights reserved.
//

// MARK: - ** Import Modules **

import UIKit

// MARK: - ** UIFilterView - Overlay UIView Subclass ** -

/// A `UIView` subclass that can overlay any other views, but does not receive
/// any touch events; AKA you can interact with views under/behind this view.
public class UIFilterView: UIView {

    override public func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        return nil
    }
    
}
