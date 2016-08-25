//
//  UIToolbar.swift
//  NoodleBox
//
//  Created by Thom Morgan on 7/16/16.
//  Copyright © 2016 NoodleOfDeath. All rights reserved.
//

import UIKit
import Foundation

extension UIToolbar {
    
    public convenience init(items: [UIBarButtonItem]) {
        self.init()
        self.items = items
    }
    
}