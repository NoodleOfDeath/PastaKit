//
//  UIPaddedTextField.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 8/22/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import UIKit
import Foundation

public class UIPaddedTextField : UITextField {
    
    public var padding: CGSize = CGSizeMake(5.0, 5.0) {
        didSet { setNeedsDisplay() }
    }
    
    public override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, padding.width, padding.height)
    }
    
    public override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, padding.width, padding.height)
    }
    
}