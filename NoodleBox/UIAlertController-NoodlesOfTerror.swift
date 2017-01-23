//
//  UIAlertController.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 7/20/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    /// Fix for auto-rotation bug
    open override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    /// Fix for auto-rotation bug
    open override var shouldAutorotate : Bool {
        return false
    }
    
}
