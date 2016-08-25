//
//  UIDevice.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 4/27/16.
//  Copyright © 2016 NoodleOfDeath. All rights reserved.
//

import UIKit

extension UIDevice {
    
    public static var isPortrait: Bool {
        return UIDeviceOrientationIsPortrait(currentDevice().orientation)
    }
    
    public static var isFlat: Bool {
        return currentDevice().orientation.isFlat
    }
    
    public static var isLandscape: Bool {
        return UIDeviceOrientationIsLandscape(currentDevice().orientation)
    }
    
    public static var isValidInterfaceOrientation: Bool {
        return UIDeviceOrientationIsValidInterfaceOrientation(currentDevice().orientation)
    }
    
    public static var isPortraitOrFlat: Bool {
        return isPortrait || isFlat
    }

    public static func isIphone4orLess() -> Bool {
        return currentDevice().userInterfaceIdiom == .Phone
            && UIScreen.maxDimension() < 568.0
    }

    public static func isIphone5() -> Bool {
        return currentDevice().userInterfaceIdiom == .Phone
            && UIScreen.maxDimension() == 568.0
    }

    public static func isIphone6() -> Bool {
        return currentDevice().userInterfaceIdiom == .Phone
            && UIScreen.maxDimension() == 667.0
    }

    public static func isIphone6P() -> Bool {
        return currentDevice().userInterfaceIdiom == .Phone
            && UIScreen.maxDimension() == 736.0
    }

    public static func isIpad() -> Bool {
        return (currentDevice().userInterfaceIdiom == .Pad)
            && UIScreen.maxDimension() == 1024.0
    }
    
    public static func isIpadPro() -> Bool {
        return (currentDevice().userInterfaceIdiom == .Pad)
            && UIScreen.maxDimension() == 1366.0
    }

    public static func splitViewSupported() -> Bool {
        return isIpad() || isIpadPro() || isIphone6P()
    }
    
    public static func machine() -> String? {
        var size: size_t = 0
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        let _machine = malloc(size)
        sysctlbyname("hw.machine", _machine, &size, nil, 0)
        let data = NSData(bytes: _machine, length: Int(size))
        let machine = String(data: data, encoding: NSUTF8StringEncoding)
        free(_machine)
        return machine
    }

}