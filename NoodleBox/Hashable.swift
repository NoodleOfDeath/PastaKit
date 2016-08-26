//
//  Hashable.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 7/6/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import Foundation

extension Hashable {
    
    public var hashString: String {
        return String(hashValue)
    }
    
}