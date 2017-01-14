// Copyright (c) 2016 NoodleNation <noodlebox@noodlenation.net>
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

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
