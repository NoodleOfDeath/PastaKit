//
//  UIScreen.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 4/27/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import UIKit

extension UIScreen {

    public static func width() -> CGFloat           { return UIScreen.mainScreen().bounds.size.width }
    public static func height() -> CGFloat          { return UIScreen.mainScreen().bounds.size.height }
    public static func maxDimension() -> CGFloat    { return max(width(), height()) }
    public static func minDimension() -> CGFloat    { return min(width(), height()) }

}