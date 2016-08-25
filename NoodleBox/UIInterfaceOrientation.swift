//
//  UIInterfaceOrientation.swift
//  NoodleBox
//
//  Created by Thom Morgan on 8/18/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation

extension UIInterfaceOrientation {
    
    /// The orientation of the application in terms of the status
    /// bar orientation.
    /// - note: This is not necessarily the device orientation.
    /// - returns: The orientation of the application in terms of the
    /// status bar orientation.
    /// - seealso: [`UIDeviceOrientation`]()
    public static func applicationOrientation() -> UIInterfaceOrientation {
        return UIApplication.orientation
    }
    
}