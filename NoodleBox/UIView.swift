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
        set { frame.size = CGSize(width: newValue, height: height) }
    }
    
    /// The `height` dimension of `self.frame.size`.
    public var height: CGFloat {
        get { return frame.height }
        set { frame.size = CGSize(width: width, height: newValue) }
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
    public func widthLayoutConstraint(_ width: CGFloat) -> NSLayoutConstraint {
        return layoutConstraint(attribute: .width, relativeToView: nil, constant: width)
    }
    
    /// 
    public func heightLayoutConstraint(_ height: CGFloat) -> NSLayoutConstraint {
        return layoutConstraint(attribute: .height, relativeToView: nil, constant: height)
    }
    
    /// 
    public func widthLayoutConstraintRelativeToView(_ view: UIView, multiplier m: CGFloat = 1.0, constant c: CGFloat = 0.0) -> NSLayoutConstraint {
        return layoutConstraint(attribute: .width, relativeToView: view, multiplier: m, constant: c)
    }
    
    /// 
    public func heightLayoutConstraintRelativeToView(_ view: UIView, multiplier m: CGFloat = 1.0, constant c: CGFloat = 0.0) -> NSLayoutConstraint {
        return layoutConstraint(attribute: .height, relativeToView: view, multiplier: m, constant: c)
    }
    
    /// 
    public func leftLayoutConstraintRelativeToView(_ view: UIView, multiplier m: CGFloat = 1.0, constant c: CGFloat = 0.0) -> NSLayoutConstraint {
        return layoutConstraint(attribute: .left, relativeToView: view, multiplier: m, constant: c)
    }
    
    /// 
    public func rightLayoutConstraintRelativeToView(_ view: UIView, multiplier m: CGFloat = 1.0, constant c: CGFloat = 0.0) -> NSLayoutConstraint {
        return layoutConstraint(attribute: .right, relativeToView: view, multiplier: m, constant: c)
    }
    
    /// 
    public func topLayoutConstraintRelativeToView(_ view: UIView, multiplier m: CGFloat = 1.0, constant c: CGFloat = 0.0) -> NSLayoutConstraint {
        return layoutConstraint(attribute: .top, relativeToView: view, multiplier: m, constant: c)
    }
    
    /// 
    public func bottomLayoutConstraintRelativeToView(_ view: UIView, multiplier m: CGFloat = 1.0, constant c: CGFloat = 0.0) -> NSLayoutConstraint {
        return layoutConstraint(attribute: .bottom, relativeToView: view, multiplier: m, constant: c)
    }
    
    /// 
    public func horizontalSpacingLayoutConstraintRelativeToView(_ view: UIView, multiplier m: CGFloat = 1.0, constant c: CGFloat = 0.0) -> NSLayoutConstraint {
        return layoutConstraint(attribute: .right, relativeToView: view, attribute: .left, multiplier: m, constant: c)
    }
    
    /// 
    public func verticalSpacingLayoutConstraintRelativeToView(_ view: UIView, multiplier m: CGFloat = 1.0, constant c: CGFloat = 0.0) -> NSLayoutConstraint {
        return layoutConstraint(attribute: .bottom, relativeToView: view, attribute: .top, multiplier: m, constant: c)
    }
    
    /// 
    public func centerXLayoutConstraint(_ centerX: CGFloat) -> NSLayoutConstraint {
        return layoutConstraint(attribute: .centerX, relativeToView: nil, constant: centerX)
    }
    
    /// 
    public func centerYLayoutConstraint(_ centerY: CGFloat) -> NSLayoutConstraint {
        return layoutConstraint(attribute: .centerY, relativeToView: nil, constant: centerY)
    }
    
    /// 
    public func centerXLayoutConstraintRelativeToView(_ view: UIView, multiplier m: CGFloat = 1.0, constant c: CGFloat = 0.0) -> NSLayoutConstraint {
        return layoutConstraint(attribute: .centerX, relativeToView: view, multiplier: m, constant: c)
    }
    
    /// 
    public func centerYLayoutConstraintRelativeToView(_ view: UIView, multiplier m: CGFloat = 1.0, constant c: CGFloat = 0.0) -> NSLayoutConstraint {
        return layoutConstraint(attribute: .centerY, relativeToView: view, multiplier: m, constant: c)
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
