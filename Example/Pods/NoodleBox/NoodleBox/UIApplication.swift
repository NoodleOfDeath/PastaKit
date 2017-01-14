//
// UIApplication.swift
// NoodleBox
//
// Created by NoodleOfDeath on 4/17/16.
// Copyright © 2016 NoodleNation. All rights reserved.
//

import UIKit

extension UIApplication {
    
    /// The orientation of the application in terms of the status
    /// bar orientation.
    /// - note: This is not necessarily the device orientation.
    /// - returns: The orientation of the application in terms of the
    /// status bar orientation.
    /// - seealso: [`UIDeviceOrientation`]()
    open static var orientation: UIInterfaceOrientation {
        return shared.statusBarOrientation
    }
    
    /// `true` if the `orientation` is either `.Portrait` or
    /// `.PortraitUpsideDown`
    open static var isPortrait: Bool {
        return orientation.isPortrait
    }

    /// `true` if the `orientation` is either `.LandscapeLeft` or
    /// `.LandscapeRight`
    open static var isLandscape: Bool {
        return orientation.isLandscape
    }
    
    /// The shared application delegate
    /// - returns: The shared application delegate
    open static func sharedDelegate() -> UIApplicationDelegate? {
        return shared.delegate
    }

    /// The shared application key window
    /// - returns: The shared application key window
    open static func sharedKeyWindow() -> UIWindow? {
        return shared.keyWindow
    }
    
    /// Dismiss keyboard from key window.
    open static func endEditing(_ force: Bool = false) {
        shared.keyWindow?.endEditing(force)
    }

}
