//
//  UINavigationController.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 4/25/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import Foundation

extension UINavigationController {
 
    public static func hideShowBarDuration() -> CGFloat {
        return UINavigationControllerHideShowBarDuration
    }
    
    public static func hideShowBarTimeInterval() -> NSTimeInterval {
        return NSTimeInterval(UINavigationControllerHideShowBarDuration)
    }

    public override func shouldAutorotate() -> Bool {
        return true
    }
    
    public override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return (visibleViewController?.supportedInterfaceOrientations())!
    }
    
}