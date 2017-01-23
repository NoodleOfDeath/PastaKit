//
//  UIScreen.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 4/27/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import UIKit

extension UIScreen {

    open static func width() -> CGFloat           { return UIScreen.main.bounds.size.width }
    open static func height() -> CGFloat          { return UIScreen.main.bounds.size.height }
    open static func maxDimension() -> CGFloat    { return max(width(), height()) }
    open static func minDimension() -> CGFloat    { return min(width(), height()) }

}
