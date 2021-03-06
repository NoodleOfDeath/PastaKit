//
// UIViewController.swift
// NoodleBox
//
// Created by NoodleOfDeath on 4/26/16.
// Copyright © 2016 NoodleNation. All rights reserved.
//

import Foundation

extension UIViewController {
    
    /// 
    open var ordinal: Int {
        guard let index = navigationController?.viewControllers.index(of: self) else { return NSNotFound }
        return index
    }
    
    /// 
    open var isRootViewController: Bool {
        return ordinal == 0
    }

    /// Sets the text for the back button in the navigation controller.
    open var backButtonTitle: String? {
        get {
            guard let button = navigationItem.backBarButtonItem else { return nil }
            return button.title
        }
        set {
            navigationItem.backBarButtonItem = UIBarButtonItem(title: newValue)
        }
    }
    
    /// 
    open func embeddedInsideNavigationController() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }

}
