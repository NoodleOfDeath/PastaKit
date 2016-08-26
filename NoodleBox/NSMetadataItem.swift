//
//  NSMetadataResult.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 6/19/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import UIKit

extension NSMetadataItem {
    
    public subscript (key: String) -> AnyObject? {
        get { return valueForKey(key) }
        set { setValue(newValue, forKey: key) }
    }
    
}
