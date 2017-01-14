//
// UIToolbar.swift
// NoodleBox
//
// Created by NoodleOfDeath on 7/16/16.
// Copyright © 2016 NoodleNation. All rights reserved.
//

import UIKit
import Foundation

extension UIToolbar {
    
    public convenience init(items: [UIBarButtonItem]) {
        self.init()
        self.items = items
    }
    
}
