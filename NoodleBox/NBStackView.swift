//
//  NBStackView.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 8/14/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

// MARK: - ** Import Modules **

import Foundation

// MARK: - ** Public Constants **

// MARK: - NBStackViewAlignment Enumeration

/// Possible stacking alignments for a `NBStackView`.
public enum NBStackViewAlignment : Int {
    case Horizontal
    case Vertical
}

// MARK: - ** NBStackView Class ** -

/// A `UIView` subclass that stacks subviews using auto-layout.
///
/// - note: Subviews are expected to have positive, non-zero width or height
/// constraints set to a constant for `Horizontal` and `Vertical` alignments, 
/// respectively.
///
/// **Example:**
/// ````
/// import CodeNoodle
/// ...
/// override viewDidLoad() {
///
///     super.viewDidLoad()
///
///     let viewA = UIView()
///     viewA.addConstraint(viewA.widthLayoutConstraint(40.0))
///
///     let viewB = UIView()
///     viewB.addConstraint(viewB.widthLayoutConstraint(50.0))
///
///     let label = UILabel()
///     label.text = "This is a label"
///     label.addConstraint(label.widthLayoutConstraint(100.0))
///
///     let stack = NBStackView()
///     stack.push(viewA, viewB, label)
///
///     view.addSubview(stack)
///     stack.constrainToSuperview()
/// }
/// ...
/// ````
public class NBStackView : UIView {
    
    // MARK: - ** Static Properties ** -
    
    /// Encoding/decoding keys.
    private struct CodingKeys {
        /// Key used to encode `alignment`.
        static let Alignment = "Alignment"
    }
    
    // MARK: - ** Public Properties **
    
    // MARK: - Get-Only
    
    /// `Horizontal` or `Vertical` stacking of views. Default is `Horizontal`.
    public let alignment: NBStackViewAlignment
    
    // MARK: - Stored
    
    public var margin: CGFloat = 10.0 {
        didSet {
            let views = subviews
            for view in views {
                view.removeFromSuperview()
            }
            push(views)
            UIView.animateWithDuration(0.25) { 
                self.setNeedsLayout()
            }
        }
    }
    
    // MARK: - ** Private Properties **
    
    // MARK: - Layout Constraints
    
    /// Temporary variable used to keep track of the first outermost layout
    /// constraint. This will either be the left layout constraint of the first
    /// subview, or the top layout constaint of the first subview.
    private var constraintA = NSLayoutConstraint()
    
    /// Temporary variable used to keep track of the last outermost layout
    /// constraint. This will either be the right layout constraint of the last
    /// subview, or the bottom layout constaint of the last subview.
    private var constraintB = NSLayoutConstraint()
    
    // MARK: - ** Constructor Methods ** -
    
    public required init?(coder aDecoder: NSCoder) {
        guard let alignment =
            NBStackViewAlignment(rawValue:
                aDecoder.decodeIntegerForKey(CodingKeys.Alignment))
            else { return nil }
        self.alignment = alignment
        super.init(coder: aDecoder)
    }
    
    /// Instantiates a new `NBStackView` that stacks subviews according to
    /// `alignment`.
    /// - parameter alignment: The orientation the stack view should stack
    /// subviews.
    /// - returns: A `NBStackView` instance that stacks subviews according to
    /// `alignment`.
    public required init(alignment: NBStackViewAlignment = .Horizontal) {
        self.alignment = alignment
        super.init(frame: CGRectZero)
    }
    
    // MARK: - ** Superclass Methods **
    
    // MARK: - NSCoding
    
    public override func encodeWithCoder(aCoder: NSCoder) {
        super.encodeWithCoder(aCoder)
        aCoder.encodeInteger(alignment.rawValue, forKey: CodingKeys.Alignment)
    }
    
    // MARK: - ** Public Methods ** -
    
    /// Pushes a subview onto the end of stack.
    /// - parameter view: The subview to push onto the stack.
    public func pushSubview(subview: UIView) {
        
        let first = subviews.first
        let last = subviews.last
        
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        if alignment == .Horizontal {
            addConstraint(subview.topLayoutConstraintRelativeToView(self))
            addConstraint(subview.bottomLayoutConstraintRelativeToView(self))
            addConstraint(subview.centerYLayoutConstraintRelativeToView(self))
        } else {
            addConstraint(subview.leftLayoutConstraintRelativeToView(self))
            addConstraint(subview.rightLayoutConstraintRelativeToView(self))
            addConstraint(subview.centerXLayoutConstraintRelativeToView(self))
        }
        
        if first == nil {
            constraintA = alignment == .Horizontal ?
                subview.leftLayoutConstraintRelativeToView(self) :
                subview.topLayoutConstraintRelativeToView(self)
            addConstraint(constraintA)
        }
        
        if let last = last {
            removeConstraint(constraintB)
            addConstraint(alignment == .Horizontal ?
                last.horizontalSpacingLayoutConstraintRelativeToView(subview, constant: -margin) :
                last.verticalSpacingLayoutConstraintRelativeToView(subview, constant: -margin))
        }
        
        constraintB = alignment == .Horizontal ?
            subview.rightLayoutConstraintRelativeToView(self) :
            subview.bottomLayoutConstraintRelativeToView(self)
        addConstraint(constraintB)
        
    }
    
    /// Convenience method that pushes multiple subviews onto the end of the 
    /// stack in FIFO order
    /// - parameter views: The subviews to push onto the end of the stack
    public func push(views: UIView...) {
        for view in views { pushSubview(view) }
    }
    
    /// Convenience method that pushes an array of subviews onto the end of the
    /// stack in FIFO order
    /// - parameter views: The subviews to push onto the end of the stack
    public func push(views: [UIView]) {
        for view in views { pushSubview(view) }
    }
    
}

