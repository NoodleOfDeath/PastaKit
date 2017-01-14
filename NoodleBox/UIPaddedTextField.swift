//
// UIPaddedTextField.swift
// NoodleBox
//
// Created by NoodleOfDeath on 8/22/16.
// Copyright © 2016 NoodleNation. All rights reserved.
//

import UIKit
import Foundation

open class UIPaddedTextField : UITextField {
    
    open var padding: CGSize = CGSize(width: 5.0, height: 5.0) {
        didSet { setNeedsDisplay() }
    }
    
    open override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding.width, dy: padding.height)
    }
    
    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding.width, dy: padding.height)
    }
    
}
