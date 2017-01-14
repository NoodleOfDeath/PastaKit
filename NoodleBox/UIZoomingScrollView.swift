//
// UIZoomingScrollView.swift
// NoodleBox
//
// Created by NoodleOfDeath on 5/17/16.
// Copyright © 2016 NoodleNation. All rights reserved.
//

// MARK: - ** Import Modules **

import UIKit

// MARK: - ** Protocols **

// MARK: - UIZoomingScrollViewDelegate Protocol

/// A composite protocol of the `UIScrollViewDelegate` that sends events
/// from the embedded custom scroll view to a delegate object.
public protocol UIZoomingScrollViewDelegate : NSObjectProtocol {
    func scrollViewDidScroll(_ scrollView: UIScrollView)
}

// MARK: - ** UIZoomingScrollView - UIScrollView Composite Class ** -

/// A `UIView` class that enables zooming for a custome scroll view
///
/// **Example:**
/// ````
/// import NoodleBox
/// ...
/// override func viewDidLoad() {
///    super.viewDidLoad()
///    let textView = UITextView()
///    textView.text = "This is a text view"
///    let zview = UIZoomingScrollView(scrollView: textView)
///    view.addSubview(zview)
///    zview.constrainToSuperview()
/// }
/// ...
/// ````
open class UIZoomingScrollView : UIView, UIScrollViewDelegate {
    
    // MARK: - ** Static Properties ** -
    
    /// The default minimum zoom scale
    static let DefaultMinimumZoomScale: CGFloat = 0.25
    
    /// The default maximum zoom scale
    static let DefaultMaximumZoomScale: CGFloat = 4.0
    
    // MARK: - ** Internal Properties **
    
    // MARK: - Weak References
    
    /// The delegating object that receives event notifications from this
    /// scroll view.
    open weak var delegate: UIZoomingScrollViewDelegate?
    
    // MARK: - Composite (UIScrollView)
    
    /// Enable/disable zooming of the custom scroll view.
    open var enableZoom = true {
        didSet {
            zoomScale = enableZoom ? zoomScale : 1.0
            minimumZoomScale = enableZoom ?
                UIZoomingScrollView.DefaultMinimumZoomScale : 1.0
            maximumZoomScale = enableZoom ?
                UIZoomingScrollView.DefaultMaximumZoomScale : 1.0
        }
    }
    
    /// A floating-point value that specifies the current scale factor
    /// applied to the scroll view's content.
    ///
    /// This value determines how much the content is currently scaled. 
    /// The default value is 1.0.
    open var zoomScale: CGFloat {
        get { return contentScrollView.zoomScale }
        set { contentScrollView.zoomScale = newValue }
    }
    
    /// A floating-point value that specifies the minimum scale factor that 
    /// can be applied to the scroll view's content.
    ///
    /// This value determines how small the content can be scaled. 
    /// The default value is 1.0
    open var minimumZoomScale: CGFloat {
        get { return contentScrollView.minimumZoomScale }
        set { contentScrollView.minimumZoomScale = newValue }
    }
    
    /// A floating-point value that specifies the maximum scale factor that 
    /// can be applied to the scroll view's content.
    ///
    /// This value determines how large the content can be scaled. It must be 
    /// greater than the minimum zoom scale for zooming to be enabled. 
    /// The default value is 1.0.
    open var maximumZoomScale: CGFloat {
        get { return contentScrollView.maximumZoomScale }
        set { contentScrollView.maximumZoomScale = newValue }
    }
    
    /// The size to set the content scroll view.
    /// - note: This is not the size of the custom scroll view. The width of
    /// the custom scroll view is equal to `contentView.width` and
    /// `contentScrollView.contentSize.contentSize.width`. The custom scroll
    /// view (or its view controller) is responsible for setting its content
    /// size height.
    open var contentSize: CGSize = CGSize.zero {
        didSet { updateDimensions() }
    }
    
    /// The vertical offset of the content view
    open var verticalOffset: CGFloat = 0.0 {
        didSet { updateDimensions() }
    }
    
    /// The initial padding used by the custom scroll view
    /// - note: During zooming, this padding is adjusted with respect to the
    /// zoomScale so that it remains the same size visually.
    open var defaultContentInset = UIEdgeInsets(top: 0.0, left: 0.0,
                                                  bottom: 0.0, right: 0.0) {
        didSet { updateDimensions() }
    }
    
    // MARK: - Composite (NSLayoutConstraint)
    
    /// The y coordinate of the scroll indicator
    open var scrollIndicatorVerticalOffset: CGFloat = 0.0 {
        didSet { scrollIndicatorTopLayoutConstraint.constant =
            scrollIndicatorVerticalOffset }
    }
    
    /// The width of the scroll indicator
    open var scrollIndicatorWidth: CGFloat = 2.5 {
        didSet { scrollIndicatorWidthLayoutConstraint.constant =
            scrollIndicatorWidth }
    }
    
    /// The height of the scroll indicator
    open var scrollIndicatorHeight: CGFloat = 0.0 {
        didSet { scrollIndicatorHeightLayoutConstraint.constant =
            scrollIndicatorHeight }
    }
    
    // MARK: - UI Components
    
    /// The custom scroll view to make zoomable.
    open var scrollView: UIScrollView? {
        didSet {
            guard let scrollView = scrollView else { return }
            contentView.addSubview(scrollView)
            scrollView.constrainToSuperview()
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.showsVerticalScrollIndicator = false
            defaultContentInset = scrollView.contentInset
        }
    }
    
    // MARK: - ** Private Properties **
    
    // MARK: - Stored
    
    /// Indicates whether the scale view is visible or not.
    fileprivate lazy var scaleViewVisible = false
    
    // MARK: - UI Components
    
    /// The scroll view that handles horizontal scrolling.
    fileprivate lazy var contentScrollView: UIScrollView = {
        let contentScrollView = UIScrollView()
        contentScrollView.addSubview(self.contentView)
        contentScrollView.delegate = self
        contentScrollView.scrollsToTop = false
        contentScrollView.showsVerticalScrollIndicator = false
        return contentScrollView
    }()
    
    /// The view that contains the custom scroll view.
    fileprivate lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate lazy var scrollIndicator: UIView = {
        let scrollIndicator = UIView()
        scrollIndicator.translatesAutoresizingMaskIntoConstraints = false
        scrollIndicator.backgroundColor = .gray * 0.85
        scrollIndicator.layer.cornerRadius = 1.25
        return scrollIndicator
    }()
    
    /// The view containing the scale label
    fileprivate lazy var scaleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(view.widthLayoutConstraint(75.0))
        view.addConstraint(view.heightLayoutConstraint(50.0))
        view.backgroundColor = .black * 0.75
        view.layer.cornerRadius = 5.0
        view.addSubview(self.scaleLabel)
        self.scaleLabel.constrainToSuperview()
        return view
    }()
    
    /// The label that displays the zoom scale as a percentage. For
    /// example if `zoomScale = 0.5` this label will display `"50%".
    fileprivate lazy var scaleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Layout Constraints
    
    /// Content view width constraint
    fileprivate lazy var contentViewWidthLayoutConstraint: NSLayoutConstraint = {
        return self.contentView.widthLayoutConstraint(self.contentSize.width)
    }()
    
    /// Content view height constraint
    /// - note: The height of the content view will always be exactly the
    /// the same height as its parent view (this view) with respect to the
    /// zoomScale. Thus, the content scroll view will never be able to scroll
    /// vertically, leaving that responsibility to the scroll view contained
    /// inside the content view.
    fileprivate lazy var contentViewHeightLayoutConstraint: NSLayoutConstraint = {
        return self.contentView.heightLayoutConstraint(
            self.height / self.zoomScale)
    }()
    
    /// Scroll indicator y coordinate constraint
    fileprivate lazy var scrollIndicatorTopLayoutConstraint: NSLayoutConstraint = {
        return self.scrollIndicator.topLayoutConstraintRelativeToView(
            self, constant: self.scrollIndicatorVerticalOffset)
    }()
    
    /// Scroll indicator width constraint
    fileprivate lazy var scrollIndicatorWidthLayoutConstraint:
        NSLayoutConstraint = {
        return self.scrollIndicator.widthLayoutConstraint(
            self.scrollIndicatorWidth)
    }()
    
    /// Scroll indicator height constraint
    fileprivate lazy var scrollIndicatorHeightLayoutConstraint:
        NSLayoutConstraint = {
        return self.scrollIndicator.heightLayoutConstraint(
            self.scrollIndicatorHeight)
    }()
    
    // MARK: - ** Constructor Methods ** -
    
    public convenience init() {
        
        self.init(frame: UIScreen.main.applicationFrame)
        
        contentView.addConstraint(contentViewWidthLayoutConstraint)
        contentView.addConstraint(contentViewHeightLayoutConstraint)
        
        addSubview(contentScrollView)
        contentScrollView.constrainToSuperview()
        
        addSubview(scrollIndicator)
        
        scrollIndicator.addConstraint(scrollIndicatorWidthLayoutConstraint)
        scrollIndicator.addConstraint(scrollIndicatorHeightLayoutConstraint)
        
        addConstraint(scrollIndicatorTopLayoutConstraint)
        addConstraint(scrollIndicator.rightLayoutConstraintRelativeToView(self,
            constant: -4.0))
        
    }
    
    /// Convenience initializer that takes an initial scroll view parameter
    /// - parameter scrollView: The initial scroll view
    /// - returns: An initialized `UIZoomingScrollView` that enables graphical
    /// zooming for `scrollView`.
    public convenience init(scrollView: UIScrollView) {
        self.init()
        self.scrollView = scrollView
    }
    
    // MARK: - ** Superclass/Protocol Methods **
    
    // MARK: - UIView
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        updateDimensions()
    }
    
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        if view == contentScrollView {
            let point = contentScrollView.convert(point, to: scrollView)
            return scrollView?.hitTest(point, with: event) ?? scrollView
        }
        return view
    }
    
    // MARK: - ** Protocol Methods **
    
    // MARK: - UIScrollViewDelegate
    
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateScrollIndicator()
    }
    
    open func scrollViewDidZoom(_ scrollView: UIScrollView) {
        showScaleView()
        updateDimensions()
    }
    
    open func viewForZooming(in scrollView: UIScrollView) ->
        UIView? {
        return contentView
    }
    
    open func scrollViewDidEndZooming(_ scrollView: UIScrollView,
                                        with view: UIView?,
                                                 atScale scale: CGFloat) {
        if scale >= 0.95 && scale <= 1.05 {
            scrollView.zoomScale = 1.0
        } else if (scale * 100) != round(scale * 100) {
            scrollView.zoomScale = round(scale * 100) / 100
        }
    }
    
    // MARK: - ** Public Methods **
    
    // MARK: - Composite (UIScrollView)
    
    /// Scrolls so that `rect` is just visible (nearest edges).
    /// Does nothing if `rect` completely visible.
    open func scrollRectToVisible(_ rect: CGRect, animated: Bool) {
        contentScrollView.scrollRectToVisible(rect, animated: animated)
    }
    
    // MARK: - ** Private Methods ** -
    
    /// Updates the dimensions of the vertical scroll indicator
    fileprivate func updateScrollIndicator() {
        
        guard let scrollView = scrollView else { return }
        guard scrollView.contentSize.height > 0 else { return }
        
        let gutter = scrollView.contentInset.top +
            scrollView.contentInset.bottom
        let offsetHeight = contentSize.height - gutter
        let offsetRatio = (scrollView.contentOffset.y /
            scrollView.contentSize.height)
        let sizeRatio = (offsetHeight / scrollView.contentSize.height)
        
        scrollIndicatorVerticalOffset = offsetRatio * offsetHeight +
            (scrollView.contentInset.top * zoomScale)
        scrollIndicatorHeight = ((sizeRatio * offsetHeight) / zoomScale)
        
        if scrollIndicatorHeight >= offsetHeight {
            scrollIndicator.alpha = 0.0
            return
        }
        
        scrollIndicator.alpha = 1.0
        delay(0.5) {
            UIView.animate(withDuration: 0.25, animations: {
                self.scrollIndicator.alpha = 0.0
            })
        }
        
    }
    
    /// Updates the dimensions of the inner scroll view
    fileprivate func updateDimensions() {
        
        let margin =
            (contentSize.width * zoomScale <= width) ?
                ((zoomScale < 1.0) ? (width / 2 -
                    (contentSize.width * zoomScale) / 2) : 0.0) : 0.0
        
        contentViewWidthLayoutConstraint.constant = contentSize.width
        contentViewHeightLayoutConstraint.constant =
            (contentSize.height / zoomScale)
        
        contentScrollView.contentInset = UIEdgeInsets(top: verticalOffset,
                                                      left: margin,
                                                      bottom: 0.0,
                                                      right: margin)
        contentScrollView.contentSize = CGSize(
            width: contentSize.width * zoomScale, height: height - verticalOffset)
        
        scrollView?.setNeedsDisplay()
        scrollView?.contentInset = UIEdgeInsets(
            top: defaultContentInset.top / zoomScale,
            left: 0.0,
            bottom: defaultContentInset.bottom / zoomScale,
            right: 0.0)
        updateScrollIndicator()
        
    }
    
    /// Shows the scale view for 0.5 seconds
    fileprivate func showScaleView() {
        
        scaleLabel.text = "\(round(zoomScale * 100))%"
        
        if !scaleViewVisible {
            
            scaleViewVisible = true
            
            addSubview(scaleView)
            addConstraint(scaleView.centerXLayoutConstraintRelativeToView(self))
            addConstraint(scaleView.centerYLayoutConstraintRelativeToView(self))
            
            scaleView.alpha = 0.0
            
            UIView.animate(withDuration: 0.5, animations: {
                self.scaleView.alpha = 1.0
            }) 
            
            delay(0.5) { self.hideScaleView() }
            
        }
        
    }
    
    /// Hides the scale view
    fileprivate func hideScaleView() {
        UIView.animate(withDuration: 0.5, animations: { 
            self.scaleView.alpha = 0.0
        }, completion: { (Bool) in
            self.scaleView.removeFromSuperview()
            self.scaleViewVisible = false
        }) 
    }
    
}
