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
    
    public static func hideShowBarTimeInterval() -> TimeInterval {
        return TimeInterval(UINavigationControllerHideShowBarDuration)
    }

    open override var shouldAutorotate : Bool {
        return true
    }
    
    open override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return (visibleViewController?.supportedInterfaceOrientations)!
    }
    
}
