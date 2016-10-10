//
//  UIDevice.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 4/27/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import UIKit

extension UIDevice {
    
    public static var isPortrait: Bool {
        return UIDeviceOrientationIsPortrait(current.orientation)
    }
    
    public static var isFlat: Bool {
        return current.orientation.isFlat
    }
    
    public static var isLandscape: Bool {
        return UIDeviceOrientationIsLandscape(current.orientation)
    }
    
    public static var isValidInterfaceOrientation: Bool {
        return UIDeviceOrientationIsValidInterfaceOrientation(current.orientation)
    }
    
    public static var isPortraitOrFlat: Bool {
        return isPortrait || isFlat
    }

    public static func isIphone4orLess() -> Bool {
        return current.userInterfaceIdiom == .phone
            && UIScreen.maxDimension() < 568.0
    }

    public static func isIphone5() -> Bool {
        return current.userInterfaceIdiom == .phone
            && UIScreen.maxDimension() == 568.0
    }

    public static func isIphone6() -> Bool {
        return current.userInterfaceIdiom == .phone
            && UIScreen.maxDimension() == 667.0
    }

    public static func isIphone6P() -> Bool {
        return current.userInterfaceIdiom == .phone
            && UIScreen.maxDimension() == 736.0
    }

    public static func isIpad() -> Bool {
        return (current.userInterfaceIdiom == .pad)
            && UIScreen.maxDimension() == 1024.0
    }
    
    public static func isIpadPro() -> Bool {
        return (current.userInterfaceIdiom == .pad)
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
        let data = Data(bytes: UnsafePointer<UInt8>(_machine), count: Int(size))
        let machine = String(data: data, encoding: String.Encoding.utf8)
        free(_machine)
        return machine
    }

}
