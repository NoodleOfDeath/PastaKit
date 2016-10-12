//
//  UIDevice.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 4/27/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import UIKit

extension UIDevice {
    
    open static var isPortrait: Bool {
        return UIDeviceOrientationIsPortrait(current.orientation)
    }
    
    open static var isFlat: Bool {
        return current.orientation.isFlat
    }
    
    open static var isLandscape: Bool {
        return UIDeviceOrientationIsLandscape(current.orientation)
    }
    
    open static var isValidInterfaceOrientation: Bool {
        return UIDeviceOrientationIsValidInterfaceOrientation(current.orientation)
    }
    
    open static var isPortraitOrFlat: Bool {
        return isPortrait || isFlat
    }

    open static func isIphone4orLess() -> Bool {
        return current.userInterfaceIdiom == .phone
            && UIScreen.maxDimension() < 568.0
    }

    open static func isIphone5() -> Bool {
        return current.userInterfaceIdiom == .phone
            && UIScreen.maxDimension() == 568.0
    }

    open static func isIphone6() -> Bool {
        return current.userInterfaceIdiom == .phone
            && UIScreen.maxDimension() == 667.0
    }

    open static func isIphone6P() -> Bool {
        return current.userInterfaceIdiom == .phone
            && UIScreen.maxDimension() == 736.0
    }

    open static func isIpad() -> Bool {
        return (current.userInterfaceIdiom == .pad)
            && UIScreen.maxDimension() == 1024.0
    }
    
    open static func isIpadPro() -> Bool {
        return (current.userInterfaceIdiom == .pad)
            && UIScreen.maxDimension() == 1366.0
    }

    open static func splitViewSupported() -> Bool {
        return isIpad() || isIpadPro() || isIphone6P()
    }
    
    open static func machine() -> String? {
        var size: size_t = 0
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        guard let _machine = malloc(size) else { return nil }
        sysctlbyname("hw.machine", _machine, &size, nil, 0)
        let data = Data(bytes: UnsafePointer<UInt8>(_machine.assumingMemoryBound(to: UInt8.self)), count: Int(size))
        let machine = String(data: data, encoding: String.Encoding.utf8)
        free(_machine)
        return machine
    }

}
