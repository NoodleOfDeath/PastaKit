//
//  NSObject.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 6/10/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import UIKit

extension NSObject {
    
    open func beginObserving(selector aSelector: Selector, name aName: String?, object anObject: Any?) {
        NotificationCenter.default.addObserver(self, selector: aSelector, name: aName.map { NSNotification.Name(rawValue: $0) }, object: anObject)
    }
    
    open func stopObserving(name aName: String?, object anObject: Any?) {
        NotificationCenter.default.removeObserver(self, name: aName.map { NSNotification.Name(rawValue: $0) }, object: anObject)
    }
    
    open func postNotificationName(_ name: String, object anObject: Any? = nil, userInfo info: [AnyHashable: Any]? = nil) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: name), object: (anObject ?? self), userInfo: info)
    }
    
}
