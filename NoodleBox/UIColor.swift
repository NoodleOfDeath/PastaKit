//
//  UIColor.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 4/20/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import Foundation

public let NSColorCode = "NSColorCode"
public let NSAlpha = "NSAlpha"

public func * (lhs: UIColor, rhs: CGFloat) -> UIColor {
    return lhs.colorWithAlphaComponent(rhs)
}

public func * (lhs: UIColor, rhs: Double) -> UIColor {
    return lhs.colorWithAlphaComponent(rhs.asCGFloat)
}

extension UIColor {

    /**
    The six-digit hexadecimal representation of color of the form #RRGGBB.
    - parameter hex6: Six-digit hexadecimal value.
    */
    public convenience init(hex6: UInt, alpha: CGFloat = 1.0) {
        let divisor = CGFloat(255.0)
        let red     = CGFloat((hex6 & 0xFF0000) >> 16) / divisor
        let green   = CGFloat((hex6 & 0x00FF00) >>  8) / divisor
        let blue    = CGFloat( hex6 & 0x0000FF       ) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    /**
    The six-digit hexadecimal representation of color with alpha of the form #RRGGBBAA.
    - parameter hex8: Eight-digit hexadecimal value.
    */
    public convenience init(hex8: UInt) {
        let divisor = CGFloat(255.0)
        let red     = CGFloat((hex8 & 0xFF000000) >> 24) / divisor
        let green   = CGFloat((hex8 & 0x00FF0000) >> 16) / divisor
        let blue    = CGFloat((hex8 & 0x0000FF00) >>  8) / divisor
        let alpha   = CGFloat( hex8 & 0x000000FF       ) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    public static func colorWithObject(obj: AnyObject?) -> UIColor? {

        guard let obj = obj else { return nil }
        
        func parseColorCode(code: AnyObject?) -> UInt? {
            
            guard let code = code else { return nil }
            
            switch code {
                
            case let code as UInt:
                return code
                
            case let code as String:
                return UInt(code)
                
            default:
                return nil
                
            }
            
        }

        switch obj {
            
        case let dict as PropertyList:
            guard let hexcode = parseColorCode(dict[NSColorCode]) else { return nil }
            let alpha = dict[NSAlpha] as? CGFloat ?? 1.0
            return UIColor(hex6: hexcode, alpha: alpha)
            
        default:
            break
            
        }
        
        return nil

    }

}