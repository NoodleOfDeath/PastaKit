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
        NotificationCenter.default.addObserver(self, selector: aSelector, name: aName.map { NSNotification.Name(rawValue: $0) }, object: anObject)
    }
    
    public func stopObserving(name aName: String?, object anObject: AnyObject?) {
        NotificationCenter.default.removeObserver(self, name: aName.map { NSNotification.Name(rawValue: $0) }, object: anObject)
    }
    
    public func postNotificationName(_ name: String, object anObject: AnyObject? = nil, userInfo info: [AnyHashable: Any]? = nil) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: name), object: (anObject ?? self), userInfo: info)
    }
    
}
