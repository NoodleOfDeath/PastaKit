//
//  NSObject.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 6/10/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import UIKit

extension NSObject {
    
    public func beginObserving(selector aSelector: Selector, name aName: String?, object anObject: AnyObject?) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: aSelector, name: aName, object: anObject)
    }
    
    public func stopObserving(name aName: String?, object anObject: AnyObject?) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: aName, object: anObject)
    }
    
    public func postNotificationName(name: String, object anObject: AnyObject? = nil, userInfo info: [NSObject: AnyObject]? = nil) {
        NSNotificationCenter.defaultCenter().postNotificationName(name, object: (anObject ?? self), userInfo: info)
    }
    
}