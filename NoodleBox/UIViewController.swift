//
//  UIViewController.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 4/26/16.
//  Copyright © 2016 NoodleOfDeath. All rights reserved.
//

import Foundation

extension UIViewController {

    public var index: Int {
        guard let index = navigationController?.viewControllers.indexOf(self) else { return NSNotFound }
        return index
    }

    public var isRootViewController: Bool {
        return index == 0
    }

    public var backButtonTitle: String? {
        get {
            if index < 1 { return nil }
            guard let button = navigationController?.navigationBar.items?[index - 1] else { return nil }
            return button.title
        }
        set {
            if index < 1 { return }
            guard let button = navigationController?.navigationBar.items?[index - 1] else { return }
            button.title = newValue
        }
    }

    public func embeddedInsideNavigationController() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }

}