//
// UIImage.swift
// NoodleBox
//
// Created by NoodleOfDeath on 6/8/16.
// Copyright © 2016 NoodleNation. All rights reserved.
//

import UIKit
import CoreImage

extension UIImage {
    
    open var width: CGFloat {
        return size.width
    }
    
    open var height: CGFloat {
        return size.height
    }
    
}


extension UIImage {
    
    open func imageByCroppingToRect(_ rect: CGRect) -> UIImage? {
        if let image = self.cgImage?.cropping(to: rect) {
            return UIImage(cgImage: image)
        } else if let image = (self.ciImage)?.cropping(to: rect) {
            return UIImage(ciImage: image)
        }
        return nil
    }
    
    open func imageByScalingAndCroppingForSize(_ targetSize: CGSize) -> UIImage? {
        
        let sourceImage = self
        
        var newImage: UIImage?
        
        var scaleFactor: CGFloat = 0.0
        var scaledWidth: CGFloat = targetSize.width
        var scaledHeight: CGFloat = targetSize.height
        
        var thumbnailPoint: CGPoint = CGPoint(x: 0.0, y: 0.0)
        
        if (sourceImage.size != targetSize) {
            
            let widthFactor = targetSize.width / width
            let heightFactor = targetSize.height / height
            
            if (widthFactor > heightFactor) { // Scale to fit height
                scaleFactor = widthFactor
            } else{ // Scale to fit width
                scaleFactor = heightFactor
            }
            
            scaledWidth = width * scaleFactor
            scaledHeight = height * scaleFactor
            
            // Center the image
            if (widthFactor > heightFactor) {
                thumbnailPoint.y = (targetSize.height - scaledHeight) * 0.5 // Could not find an overload for '*' that accepts the supplied arguments
            } else{
                if (widthFactor < heightFactor) {
                    thumbnailPoint.x = (targetSize.width - scaledWidth) * 0.5 // Could not find an overload for '*' that accepts the supplied arguments
                }
            }
            
        }
        
        UIGraphicsBeginImageContext(targetSize)
        
        var thumbnailRect: CGRect = CGRect.zero
        thumbnailRect.origin = thumbnailPoint
        thumbnailRect.size.width = scaledWidth // Cannot convert the expression's type '()' to type 'CGFloat'
        thumbnailRect.size.height = scaledHeight // Cannot convert the expression's type '()' to type 'CGFloat'
        
        sourceImage.draw(in: thumbnailRect)
        
        newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // pop the context to get back to the default
        UIGraphicsEndImageContext()
        
        return newImage
        
    }
    
}
