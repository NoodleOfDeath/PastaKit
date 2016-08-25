//
//  UIView.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 2/28/16.
//  Copyright © 2016 NoodleOfDeath. All rights reserved.
//

import UIKit

extension UIView {
    
    public var origin: CGPoint {
        return frame.origin
    }
    
    public var size: CGSize {
        return frame.size
    }

    public var x: CGFloat {
        return frame.x
    }

    public var y: CGFloat {
        return frame.y
    }

    public var width: CGFloat {
        return frame.width
    }

    public var height: CGFloat {
        return frame.height
    }
    
}

extension UIView {

    public func layoutConstraint(attribute attr: NSLayoutAttribute, relativeToView view: UIView?, multiplier m: CGFloat = 1.0, constant c: CGFloat = 0.0) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self, attribute: attr, toItem: view, multiplier: m, constant: c)
    }

    public func layoutConstraint(attribute attr1: NSLayoutAttribute, relativeToView view: UIView?, attribute attr2: NSLayoutAttribute, multiplier m: CGFloat = 1.0, constant c: CGFloat = 0.0) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self, attribute: attr1, toItem: view, attribute: attr2, multiplier: m, constant: c)
    }

    public func widthLayoutConstraint(width: CGFloat) -> NSLayoutConstraint {
        return layoutConstraint(attribute: .Width, relativeToView: nil, constant: width)
    }

    public func heightLayoutConstraint(height: CGFloat) -> NSLayoutConstraint {
        return layoutConstraint(attribute: .Height, relativeToView: nil, constant: height)
    }

    public func widthLayoutConstraintRelativeToView(view: UIView, multiplier m: CGFloat = 1.0, constant c: CGFloat = 0.0) -> NSLayoutConstraint {
        return layoutConstraint(attribute: .Width, relativeToView: view, multiplier: m, constant: c)
    }

    public func heightLayoutConstraintRelativeToView(view: UIView, multiplier m: CGFloat = 1.0, constant c: CGFloat = 0.0) -> NSLayoutConstraint {
        return layoutConstraint(attribute: .Height, relativeToView: view, multiplier: m, constant: c)
    }

    public func leftLayoutConstraintRelativeToView(view: UIView, multiplier m: CGFloat = 1.0, constant c: CGFloat = 0.0) -> NSLayoutConstraint {
        return layoutConstraint(attribute: .Left, relativeToView: view, multiplier: m, constant: c)
    }

    public func rightLayoutConstraintRelativeToView(view: UIView, multiplier m: CGFloat = 1.0, constant c: CGFloat = 0.0) -> NSLayoutConstraint {
        return layoutConstraint(attribute: .Right, relativeToView: view, multiplier: m, constant: c)
    }

    public func topLayoutConstraintRelativeToView(view: UIView, multiplier m: CGFloat = 1.0, constant c: CGFloat = 0.0) -> NSLayoutConstraint {
        return layoutConstraint(attribute: .Top, relativeToView: view, multiplier: m, constant: c)
    }

    public func bottomLayoutConstraintRelativeToView(view: UIView, multiplier m: CGFloat = 1.0, constant c: CGFloat = 0.0) -> NSLayoutConstraint {
        return layoutConstraint(attribute: .Bottom, relativeToView: view, multiplier: m, constant: c)
    }

    public func horizontalSpacingLayoutConstraintRelativeToView(view: UIView, multiplier m: CGFloat = 1.0, constant c: CGFloat = 0.0) -> NSLayoutConstraint {
        return layoutConstraint(attribute: .Right, relativeToView: view, attribute: .Left, multiplier: m, constant: c)
    }

    public func verticalSpacingLayoutConstraintRelativeToView(view: UIView, multiplier m: CGFloat = 1.0, constant c: CGFloat = 0.0) -> NSLayoutConstraint {
        return layoutConstraint(attribute: .Bottom, relativeToView: view, attribute: .Top, multiplier: m, constant: c)
    }

    public func centerXLayoutConstraint(centerX: CGFloat) -> NSLayoutConstraint {
        return layoutConstraint(attribute: .CenterX, relativeToView: nil, constant: centerX)
    }

    public func centerYLayoutConstraint(centerY: CGFloat) -> NSLayoutConstraint {
        return layoutConstraint(attribute: .CenterY, relativeToView: nil, constant: centerY)
    }

    public func centerXLayoutConstraintRelativeToView(view: UIView, multiplier m: CGFloat = 1.0, constant c: CGFloat = 0.0) -> NSLayoutConstraint {
        return layoutConstraint(attribute: .CenterX, relativeToView: view, multiplier: m, constant: c)
    }

    public func centerYLayoutConstraintRelativeToView(view: UIView, multiplier m: CGFloat = 1.0, constant c: CGFloat = 0.0) -> NSLayoutConstraint {
        return layoutConstraint(attribute: .CenterY, relativeToView: view, multiplier: m, constant: c)
    }

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
