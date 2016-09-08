//
//  UIView.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 2/28/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import UIKit

extension UIView {
    
    /// 
    public var origin: CGPoint {
        get { return frame.origin }
        set { frame.origin = newValue }
    }
    
    /// 
    public var size: CGSize {
        get { return frame.size }
        set { frame.size = newValue }
    }
    
    /// 
    public var x: CGFloat {
        get { return frame.x }
        set { frame.x = newValue }
    }
    
    /// The `y` dimension of `self.frame`. 
    public var y: CGFloat {
        get { return frame.y }
        set { frame.y = newValue }
    }
    
    /// The `width` dimension of `self.frame.size`.
    public var width: CGFloat {
        get { return frame.size.width }
        set { frame.size = CGSizeMake(newValue, height) }
    }
    
    /// The `height` dimension of `self.frame.size`.
    public var height: CGFloat {
        get { return frame.height }
        set { frame.size = CGSizeMake(width, newValue) }
    }
    
}

extension UIView {

    /// 
    public func layoutConstraint(attribute attr: NSLayoutAttribute, relativeToView view: UIView?, multiplier m: CGFloat = 1.0, constant c: CGFloat = 0.0) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self, attribute: attr, toItem: view, multiplier: m, constant: c)
    }
    
    /// 
    public func layoutConstraint(attribute attr1: NSLayoutAttribute, relativeToView view: UIView?, attribute attr2: NSLayoutAttribute, multiplier m: CGFloat = 1.0, constant c: CGFloat = 0.0) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self, attribute: attr1, toItem: view, attribute: attr2, multiplier: m, constant: c)
    }
    
    /// 
    public func widthLayoutConstraint(width: CGFloat) -> NSLayoutConstraint {
        return layoutConstraint(attribute: .Width, relativeToView: nil, constant: width)
    }
    
    /// 
    public func heightLayoutConstraint(height: CGFloat) -> NSLayoutConstraint {
        return layoutConstraint(attribute: .Height, relativeToView: nil, constant: height)
    }
    
    /// 
    public func widthLayoutConstraintRelativeToView(view: UIView, multiplier m: CGFloat = 1.0, constant c: CGFloat = 0.0) -> NSLayoutConstraint {
        return layoutConstraint(attribute: .Width, relativeToView: view, multiplier: m, constant: c)
    }
    
    /// 
    public func heightLayoutConstraintRelativeToView(view: UIView, multiplier m: CGFloat = 1.0, constant c: CGFloat = 0.0) -> NSLayoutConstraint {
        return layoutConstraint(attribute: .Height, relativeToView: view, multiplier: m, constant: c)
    }
    
    /// 
    public func leftLayoutConstraintRelativeToView(view: UIView, multiplier m: CGFloat = 1.0, constant c: CGFloat = 0.0) -> NSLayoutConstraint {
        return layoutConstraint(attribute: .Left, relativeToView: view, multiplier: m, constant: c)
    }
    
    /// 
    public func rightLayoutConstraintRelativeToView(view: UIView, multiplier m: CGFloat = 1.0, constant c: CGFloat = 0.0) -> NSLayoutConstraint {
        return layoutConstraint(attribute: .Right, relativeToView: view, multiplier: m, constant: c)
    }
    
    /// 
    public func topLayoutConstraintRelativeToView(view: UIView, multiplier m: CGFloat = 1.0, constant c: CGFloat = 0.0) -> NSLayoutConstraint {
        return layoutConstraint(attribute: .Top, relativeToView: view, multiplier: m, constant: c)
    }
    
    /// 
    public func bottomLayoutConstraintRelativeToView(view: UIView, multiplier m: CGFloat = 1.0, constant c: CGFloat = 0.0) -> NSLayoutConstraint {
        return layoutConstraint(attribute: .Bottom, relativeToView: view, multiplier: m, constant: c)
    }
    
    /// 
    public func horizontalSpacingLayoutConstraintRelativeToView(view: UIView, multiplier m: CGFloat = 1.0, constant c: CGFloat = 0.0) -> NSLayoutConstraint {
        return layoutConstraint(attribute: .Right, relativeToView: view, attribute: .Left, multiplier: m, constant: c)
    }
    
    /// 
    public func verticalSpacingLayoutConstraintRelativeToView(view: UIView, multiplier m: CGFloat = 1.0, constant c: CGFloat = 0.0) -> NSLayoutConstraint {
        return layoutConstraint(attribute: .Bottom, relativeToView: view, attribute: .Top, multiplier: m, constant: c)
    }
    
    /// 
    public func centerXLayoutConstraint(centerX: CGFloat) -> NSLayoutConstraint {
        return layoutConstraint(attribute: .CenterX, relativeToView: nil, constant: centerX)
    }
    
    /// 
    public func centerYLayoutConstraint(centerY: CGFloat) -> NSLayoutConstraint {
        return layoutConstraint(attribute: .CenterY, relativeToView: nil, constant: centerY)
    }
    
    /// 
    public func centerXLayoutConstraintRelativeToView(view: UIView, multiplier m: CGFloat = 1.0, constant c: CGFloat = 0.0) -> NSLayoutConstraint {
        return layoutConstraint(attribute: .CenterX, relativeToView: view, multiplier: m, constant: c)
    }
    
    /// 
    public func centerYLayoutConstraintRelativeToView(view: UIView, multiplier m: CGFloat = 1.0, constant c: CGFloat = 0.0) -> NSLayoutConstraint {
        return layoutConstraint(attribute: .CenterY, relativeToView: view, multiplier: m, constant: c)
    }
    
    /// Constrains a subview to its superview using auto-layout constaints.
    /// - precondition: `self` _must_ have a `superview`.
    /// - postcondition: `self.translatesAutoresizingMaskIntoConstraints = false` 
    /// and `self` will always maintain the exact same dimensions as `self.superview`.
    public func constrainToSuperview() {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        superview.addConstraints([
            leftLayoutConstraintRelativeToView(superview),
            rightLayoutConstraintRelativeToView(superview),
            topLayoutConstraintRelativeToView(superview),
            bottomLayoutConstraintRelativeToView(superview)])
    }

}
