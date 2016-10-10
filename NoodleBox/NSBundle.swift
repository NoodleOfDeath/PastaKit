//
//  NSBundle.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 5/17/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import Foundation

extension Bundle {
    
    /// Returns an image resource contained in this wrapped `NSBundle`
    /// - parameter name: The name of the image. For images in asset catalogs, 
    /// specify the name of the image asset. For PNG image files, specify the
    /// filename without the filename extension. For all other image file 
    /// formats, include the filename extension in the name.
    /// - returns: The image object that best matches the desired traits 
    /// with the given `name`, or `nil` if no suitable image was found.
    public func imageNamed(_ name: String) -> UIImage? {
        return UIImage(named: name,
                       in: self,
                       compatibleWith: .none) ?? UIImage(named: name)
    }
    
}
