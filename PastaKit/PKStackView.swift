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

// MARK: - PKStackViewAlignment Enumeration

/// Possible stacking alignments for a `PKStackView`.
public enum PKStackViewAlignment : Int {
    case horizontal
    case vertical
}

// MARK: - PKStackView Class -

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
///    let stack = PKStackView()
///    stack.push(viewA, viewB, label)
///
///    view.addSubview(stack)
///    stack.constrainToSuperview()
/// }
/// ...
/// ````
open class PKStackView : UIView {
    
    // MARK: - Static Properties -
    
    /// Encoding/decoding keys.
    fileprivate struct CodingKeys {
        /// Key used to encode `alignment`.
        static let Alignment = "Alignment"
    }
    
    // MARK: - Public Properties
    
    // MARK: - Get-Only
    
    /// `Horizontal` or `Vertical` stacking of views. Default is `Horizontal`.
    open let alignment: PKStackViewAlignment
    
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
    
    // MARK: - Private Properties
    
    // MARK: - Layout Constraints
    
    /// Temporary variable used to keep track of the first outermost layout
    /// constraint. This will either be the left layout constraint of the first
    /// subview, or the top layout constaint of the first subview.
    fileprivate var constraintA = NSLayoutConstraint()
    
    /// Temporary variable used to keep track of the last outermost layout
    /// constraint. This will either be the right layout constraint of the last
    /// subview, or the bottom layout constaint of the last subview.
    fileprivate var constraintB = NSLayoutConstraint()
    
    // MARK: - Constructor Methods -
    
    public required init?(coder aDecoder: NSCoder) {
        guard let alignment =
            PKStackViewAlignment(rawValue:
                aDecoder.decodeInteger(forKey: CodingKeys.Alignment))
            else { return nil }
        self.alignment = alignment
        super.init(coder: aDecoder)
    }
    
    /// Instantiates a new `PKStackView` that stacks subviews according to
    /// `alignment`.
    /// - parameter alignment: The orientation the stack view should stack
    /// subviews.
    /// - returns: A `PKStackView` instance that stacks subviews according to
    /// `alignment`.
    public required init(alignment: PKStackViewAlignment = .horizontal) {
        self.alignment = alignment
        super.init(frame: CGRect.zero)
    }
    
    // MARK: - Superclass/Protocol Methods
    
    // MARK: - NSCoding
    
    open override func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
        aCoder.encode(alignment.rawValue, forKey: CodingKeys.Alignment)
    }
    
    // MARK: - Public Methods -
    
    /// Pushes a subview onto the end of stack.
    /// - parameter view: The subview to push onto the stack.
    open func pushSubview(_ subview: UIView) {
        
        let first = subviews.first
        let last = subviews.last
        
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        if alignment == .horizontal {
            addConstraint(subview.topLayoutConstraint(relativeTo: self))
            addConstraint(subview.bottomLayoutConstraint(relativeTo: self))
            addConstraint(subview.centerYLayoutConstraint(relativeTo: self))
        } else {
            addConstraint(subview.leftLayoutConstraint(relativeTo: self))
            addConstraint(subview.rightLayoutConstraint(relativeTo: self))
            addConstraint(subview.centerXLayoutConstraint(relativeTo: self))
        }
        
        if first == nil {
            constraintA = alignment == .horizontal ?
                subview.leftLayoutConstraint(relativeTo: self) :
                subview.topLayoutConstraint(relativeTo: self)
            addConstraint(constraintA)
        }
        
        if let last = last {
            removeConstraint(constraintB)
            addConstraint(alignment == .horizontal ?
                last.horizontalSpacingLayoutConstraint(relativeTo: subview, constant: -margin) :
                last.verticalSpacingLayoutConstraint(relativeTo: subview, constant: -margin))
        }
        
        constraintB = alignment == .horizontal ?
            subview.rightLayoutConstraint(relativeTo: self) :
            subview.bottomLayoutConstraint(relativeTo: self)
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

