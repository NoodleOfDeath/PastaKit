//
//  Bool.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 6/12/16.
//  Copyright © 2016 NoodleOfDeath. All rights reserved.
//

import Foundation

extension Bool {
    
    public var asNumber: NSNumber {
        return NSNumber(bool: self)
    }
    
}