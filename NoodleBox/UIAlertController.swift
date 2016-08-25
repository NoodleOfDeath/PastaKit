//
//  UIAlertController.swift
//  NoodleBox
//
//  Created by Thom Morgan on 7/20/16.
//  Copyright © 2016 NoodleOfDeath. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    /// Fix for auto-rotation bug
    public override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    /// Fix for auto-rotation bug
    public override func shouldAutorotate() -> Bool {
        return false
    }
    
}