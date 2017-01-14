//
// NBStackView.swift
// NoodleBox
//
// Created by NoodleOfDeath on 8/14/16.
// Copyright © 2016 NoodleNation. All rights reserved.
//

// MARK: - ** Import Modules **

import Foundation

// MARK: - ** Public Constants **

// MARK: - NBStackViewAlignment Enumeration

/// Possible stacking alignments for a `NBStackView`.
public enum NBStackViewAlignment : Int {
    case horizontal
    case vertical
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
///    super.viewDidLoad()
///
///    let viewA = UIView()
///    viewA.addConstraint(viewA.widthLayoutConstraint(40.0))
///
///    let viewB = UIView()
///    viewB.addConstraint(viewB.widthLayoutConstraint(50.0))
///
///    let label = UILabel()
///    label.text = "This is a label"
///    label.addConstraint(label.widthLayoutConstraint(100.0))
///
///    let stack = NBStackView()
///    stack.push(viewA, viewB, label)
///
///    view.addSubview(stack)
///    stack.constrainToSuperview()
/// }
/// ...
/// ````
open class NBStackView : UIView {
    
    // MARK: - ** Static Properties ** -
    
    /// Encoding/decoding keys.
    fileprivate struct CodingKeys {
        /// Key used to encode `alignment`.
        static let Alignment = "Alignment"
    }
    
    // MARK: - ** Public Properties **
    
    // MARK: - Get-Only
    
    /// `Horizontal` or `Vertical` stacking of views. Default is `Horizontal`.
    open let alignment: NBStackViewAlignment
    
    // MARK: - Stored
    
    open var margin: CGFloat = 10.0 {
        didSet {
            let views = subviews
            for view in views {
                view.removeFromSuperview()
            }
            push(views)
            UIView.animate(withDuration: 0.25, animations: { 
                self.setNeedsLayout()
            }) 
        }
    }
    
    // MARK: - ** Private Properties **
    
    // MARK: - Layout Constraints
    
    /// Temporary variable used to keep track of the first outermost layout
    /// constraint. This will either be the left layout constraint of the first
    /// subview, or the top layout constaint of the first subview.
    fileprivate var constraintA = NSLayoutConstraint()
    
    /// Temporary variable used to keep track of the last outermost layout
    /// constraint. This will either be the right layout constraint of the last
    /// subview, or the bottom layout constaint of the last subview.
    fileprivate var constraintB = NSLayoutConstraint()
    
    // MARK: - ** Constructor Methods ** -
    
    public required init?(coder aDecoder: NSCoder) {
        guard let alignment =
            NBStackViewAlignment(rawValue:
                aDecoder.decodeInteger(forKey: CodingKeys.Alignment))
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
    public required init(alignment: NBStackViewAlignment = .horizontal) {
        self.alignment = alignment
        super.init(frame: CGRect.zero)
    }
    
    // MARK: - ** Superclass/Protocol Methods **
    
    // MARK: - NSCoding
    
    open override func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
        aCoder.encode(alignment.rawValue, forKey: CodingKeys.Alignment)
    }
    
    // MARK: - ** Public Methods ** -
    
    /// Pushes a subview onto the end of stack.
    /// - parameter view: The subview to push onto the stack.
    open func pushSubview(_ subview: UIView) {
        
        let first = subviews.first
        let last = subviews.last
        
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        if alignment == .horizontal {
            addConstraint(subview.topLayoutConstraintRelativeToView(self))
            addConstraint(subview.bottomLayoutConstraintRelativeToView(self))
            addConstraint(subview.centerYLayoutConstraintRelativeToView(self))
        } else {
            addConstraint(subview.leftLayoutConstraintRelativeToView(self))
            addConstraint(subview.rightLayoutConstraintRelativeToView(self))
            addConstraint(subview.centerXLayoutConstraintRelativeToView(self))
        }
        
        if first == nil {
            constraintA = alignment == .horizontal ?
                subview.leftLayoutConstraintRelativeToView(self) :
                subview.topLayoutConstraintRelativeToView(self)
            addConstraint(constraintA)
        }
        
        if let last = last {
            removeConstraint(constraintB)
            addConstraint(alignment == .horizontal ?
                last.horizontalSpacingLayoutConstraintRelativeToView(subview, constant: -margin) :
                last.verticalSpacingLayoutConstraintRelativeToView(subview, constant: -margin))
        }
        
        constraintB = alignment == .horizontal ?
            subview.rightLayoutConstraintRelativeToView(self) :
            subview.bottomLayoutConstraintRelativeToView(self)
        addConstraint(constraintB)
        
    }
    
    /// Convenience method that pushes multiple subviews onto the end of the 
    /// stack in FIFO order
    /// - parameter views: The subviews to push onto the end of the stack
    open func push(_ views: UIView...) {
        for view in views { pushSubview(view) }
    }
    
    /// Convenience method that pushes an array of subviews onto the end of the
    /// stack in FIFO order
    /// - parameter views: The subviews to push onto the end of the stack
    open func push(_ views: [UIView]) {
        for view in views { pushSubview(view) }
    }
    
}

