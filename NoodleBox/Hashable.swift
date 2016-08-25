//
//  Hashable.swift
//  NoodleBox
//
//  Created by Thom Morgan on 7/6/16.
//  Copyright © 2016 NoodleOfDeath. All rights reserved.
//

import Foundation

extension Hashable {
    
    public var hashString: String {
        return String(hashValue)
    }
    
}