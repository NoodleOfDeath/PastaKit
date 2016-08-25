//
//  UIApplication.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 4/17/16.
//  Copyright © 2016 NoodleOfDeath. All rights reserved.
//

import UIKit

extension UIApplication {
    
    /// The orientation of the application in terms of the status
    /// bar orientation.
    /// - note: This is not necessarily the device orientation.
    /// - returns: The orientation of the application in terms of the
    /// status bar orientation.
    /// - seealso: [`UIDeviceOrientation`]()
    public static var orientation: UIInterfaceOrientation {
        return sharedApplication().statusBarOrientation
    }
    
    /// `true` if the `orientation` is either `.Portrait` or
    /// `.PortraitUpsideDown`
    public static var isPortrait: Bool {
        return orientation.isPortrait
    }

    /// `true` if the `orientation` is either `.LandscapeLeft` or
    /// `.LandscapeRight`
    public static var isLandscape: Bool {
        return orientation.isLandscape
    }
    
    /// The shared application delegate
    /// - returns: The shared application delegate
    public static func sharedDelegate() -> UIApplicationDelegate? {
        return sharedApplication().delegate
    }

    /// The shared application key window
    /// - returns: The shared application key window
    public static func sharedKeyWindow() -> UIWindow? {
        return sharedApplication().keyWindow
    }

}