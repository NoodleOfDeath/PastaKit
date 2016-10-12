//
//  NSMetadataResult.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 6/19/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import UIKit

extension NSMetadataItem {
    
    open subscript (key: String) -> Any? {
        get { return value(forKey: key) as Any? }
        set { setValue(newValue, forKey: key) }
    }
    
}
