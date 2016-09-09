//
//  SwipeTableViewCell.swift
//  NoodleBox
//
//  Created by Thom Morgan on 2/28/16.
//  Copyright © 2016 NoodleBox. All rights reserved.
//

import UIKit

///
public protocol NBSwipeTableViewCellDelegate : NSObjectProtocol {
    
    var editing: Bool { get }
    
    func swipeTableViewCell(cell: NBSwipeTableViewCell, willShowSideView: UIView?)
    func swipeTableViewCell(cell: NBSwipeTableViewCell, didShowSideView: UIView?)
    
    func swipeTableViewCell(cell: NBSwipeTableViewCell, didRecognizePanGesture: UIPanGestureRecognizer)
    func swipeTableViewCell(cell: NBSwipeTableViewCell, didRecognizeSingleTapGesture: UITapGestureRecognizer)
    
    func swipeTableViewCellDidPressDelete(cell: NBSwipeTableViewCell)
    
    func swipeTableViewCell(cell: NBSwipeTableViewCell, didPressToolbarItem barButtonItem: UIBarButtonItem, atIndex index: Int)
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath)
    
}

extension NBSwipeTableViewCellDelegate {
    
    public func swipeTableViewCell(cell: NBSwipeTableViewCell, willShowSideView: UIView?) {}
    public func swipeTableViewCell(cell: NBSwipeTableViewCell, didShowSideView: UIView?) {}
    
    public func swipeTableViewCell(cell: NBSwipeTableViewCell, didRecognizePanGesture: UIPanGestureRecognizer) {}
    public func swipeTableViewCell(cell: NBSwipeTableViewCell, didRecognizeSingleTapGesture: UITapGestureRecognizer) {}
    
    public func swipeTableViewCellDidPressDelete(cell: NBSwipeTableViewCell) {}
    
    public func swipeTableViewCell(cell: NBSwipeTableViewCell, didPressToolbarItem barButtonItem: UIBarButtonItem, atIndex index: Int) {}
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {}
    public func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {}
    
}

/// The `SwipeTableViewCell` is a subclass of [UITableViewCell](xcdoc://?url=developer.apple.com/library/prerelease/ios/documentation/UIKit/Reference/UITableViewCell_Class/index.html) 
/// that allows the a user to swipe left or right revealing respective side views. 
/// The default cell also has a title label, a subtitle label and a default delete right view.
public class NBSwipeTableViewCell : UITableViewCell {

    // MARK: - ** Properties **
    
    ///
    public weak var delegate: NBSwipeTableViewCellDelegate?
    
    ///
    public var minWestWidth: CGFloat = 100.0
    ///
    public var minEastWidth: CGFloat = 100.0
    ///
    public var maxWestWidth: CGFloat = 180.0
    ///
    public var maxEastWidth: CGFloat = 180.0
    
    ///
    public var westViewEnabled: Bool = false {
        didSet { if !westViewEnabled { hideWestView() } }
    }
    
    ///
    public var eastViewEnabled: Bool = false {
        didSet { if !eastViewEnabled { hideEastView() } }
    }
    
    ///
    public var sideViewsEnabled: Bool = false {
        didSet { (westViewEnabled, eastViewEnabled) = (sideViewsEnabled, sideViewsEnabled) }
    }
    
    ///
    public var sideViewIsVisible: Bool {
        get { return westViewVisible || eastViewVisible }
    }
    
    ///
    public var sideViewsMoveEntireContent: Bool = true

    private var _westViewWidth: CGFloat = 0.0
    ///
    public var westViewWidth: CGFloat {
        get { return _westViewWidth }
        set {
            _westViewWidth = sideViewsEnabled ? newValue: 0.0
            westViewwidthLayoutConstraint.constant = sideViewsEnabled ? newValue: 0.0
        }
    }

    private var _eastViewWidth: CGFloat = 0.0
    ///
    public var eastViewWidth: CGFloat {
        get { return _eastViewWidth }
        set {
            _eastViewWidth = sideViewsEnabled ? newValue: 0.0
            eastViewwidthLayoutConstraint.constant = sideViewsEnabled ? newValue: 0.0
        }
    }
    
    ///
    public var imageViewWidth: CGFloat = 0.0 {
        didSet { imageViewwidthLayoutConstraint.constant = imageViewWidth }
    }
    
    ///
    public var accessoryViewWidth: CGFloat = 0.0 {
        didSet { accessoryViewwidthLayoutConstraint.constant = accessoryViewWidth}
    }

    // MARK: - ** Get-Only Properties **
    
    ///
    private (set) var westViewVisible: Bool = false
    ///
    private (set) var eastViewVisible: Bool = false

    // MARK: UI Components
    
    ///
    public var westView: UIView? {
        get { return _westView }
        set {

            _westView?.removeFromSuperview()
            _westView = newValue

            guard let view = _westView else { return }

            westViewContainer.addSubview(view)
            view.constrainToSuperview()

        }
    }
    
    ///
    public var mainView: UIView? {
        get { return _mainView }
        set {

            _mainView?.removeFromSuperview()
            _mainView = newValue

            guard let view = _mainView else { return }

            mainViewContainer.addSubview(view)
            view.constrainToSuperview()

        }
    }
    
    ///
    public var eastView: UIView? {
        get { return _eastView }
        set {

            _eastView?.removeFromSuperview()
            _eastView = newValue

            guard let view = _eastView else { return }

            eastViewContainer.addSubview(view)
            view.constrainToSuperview()

        }
    }
    
    ///
    public override var imageView: UIImageView? {
        get { return _imageView }
        set {

            _imageView?.removeFromSuperview()
            _imageView = newValue

            guard let view    = _imageView else {
                imageViewWidth = 0.0
                imageViewOffset = 0.0
                return
            }

            imageViewWidth = view.frame.size.width
            imageViewOffset = -15.0

            imageViewContainer.addSubview(view)
            view.constrainToSuperview()

        }
    }
    
    ///
    public override var accessoryView: UIView? {
        get { return _accessoryView }
        set {

            _accessoryView?.removeFromSuperview()
            _accessoryView = newValue

            guard let view = _accessoryView    else {
                accessoryViewWidth = 0.0
                accessoryViewOffset = 0.0
                return
            }

            accessoryViewWidth = view.frame.size.width
            accessoryViewOffset = -5.0

            accessoryViewContainer.addSubview(view)
            view.constrainToSuperview()

        }
    }
    
    ///
    public var accessoryToolbar: UIToolbar? {
        didSet { accessoryView = accessoryToolbar }
    }
    
    ///
    public var accessoryItems: [UIBarButtonItem]? {
        didSet {
            
            guard let accessoryItems = accessoryItems else { return }
            
            accessoryToolbar = UIToolbar()
            accessoryToolbar?.tintColor = .grayColor()
            accessoryToolbar?.setBackgroundImage(UIImage(),
                                       forToolbarPosition: .Any,
                                       barMetrics: .Default)
            accessoryToolbar?.items = accessoryItems
            
            for item in accessoryItems {
                item.target = self
                item.action = #selector(toolbarItemClicked(_:))
            }            
            
        }
    }

    // MARK: - ** Private Properties **
    
    ///
    private var westViewOffset: CGFloat = 0.0 {
        didSet { westViewOffsetLayoutConstraint.constant = westViewOffset }
    }
    ///
    private var eastViewOffset: CGFloat = 0.0 {
        didSet { eastViewOffsetLayoutConstraint.constant = eastViewOffset }
    }
    
    ///
    private var imageViewOffset: CGFloat = 0.0 {
        didSet { imageViewOffsetLayoutConstraint.constant = imageViewOffset }
    }
    ///
    private var accessoryViewOffset: CGFloat = 0.0 {
        didSet { accessoryViewOffsetLayoutConstraint.constant = accessoryViewOffset }
    }
    
    ///
    private var mainViewPadding: CGFloat = 15.0 {
        didSet {
            mainViewLeftPaddingLayoutConstraint.constant = mainViewPadding
            mainViewRightPaddingLayoutConstraint.constant = mainViewPadding
        }
    }

    // MARK: UI Components
    
    ///
    private lazy var westViewContainer: UIView = UIView()
    ///
    private lazy var mainViewContainer: UIView = UIView()
    ///
    private lazy var eastViewContainer: UIView = UIView()
    
    ///
    private lazy var imageViewContainer: UIView = UIView()
    ///
    private lazy var accessoryViewContainer: UIView = UIView()
    
    ///
    private var _westView: UIView?
    ///
    private var _mainView: UIView?
    ///
    private var _eastView: UIView?
    
    ///
    private var _imageView: UIImageView?
    ///
    private var _accessoryView: UIView?
    
    ///
    private lazy var contentViewHeightLayoutConstraint: NSLayoutConstraint = {
        return self.contentView.heightLayoutConstraint(44.0)
    }()
    
    ///
    private lazy var westViewOffsetLayoutConstraint: NSLayoutConstraint = {
        return self.westViewContainer.leftLayoutConstraintRelativeToView(self.contentView)
    }()
    
    ///
    private lazy var eastViewOffsetLayoutConstraint: NSLayoutConstraint = {
        return self.contentView.rightLayoutConstraintRelativeToView(self.eastViewContainer)
    }()
    
    ///
    private lazy var imageViewOffsetLayoutConstraint: NSLayoutConstraint = {
        return self.westViewContainer.horizontalSpacingLayoutConstraintRelativeToView(self.imageViewContainer, constant: self.imageViewOffset)
    }()
    
    ///
    private lazy var accessoryViewOffsetLayoutConstraint: NSLayoutConstraint = {
        return self.accessoryViewContainer.horizontalSpacingLayoutConstraintRelativeToView(self.eastViewContainer, constant: self.accessoryViewOffset)
    }()
    
    ///
    private lazy var mainViewLeftPaddingLayoutConstraint: NSLayoutConstraint = {
        return self.imageViewContainer.horizontalSpacingLayoutConstraintRelativeToView(self.mainViewContainer, constant: -self.mainViewPadding)
    }()
    
    ///
    private lazy var mainViewRightPaddingLayoutConstraint: NSLayoutConstraint = {
        return self.mainViewContainer.horizontalSpacingLayoutConstraintRelativeToView(self.accessoryViewContainer, constant: -self.mainViewPadding)
    }()
    
    ///
    private lazy var westViewwidthLayoutConstraint: NSLayoutConstraint = {
        return self.westViewContainer.widthLayoutConstraint(self.westViewWidth)
    }()
    
    ///
    private lazy var eastViewwidthLayoutConstraint: NSLayoutConstraint = {
        return self.eastViewContainer.widthLayoutConstraint(self.eastViewWidth)
    }()
    
    ///
    private lazy var imageViewwidthLayoutConstraint: NSLayoutConstraint = {
        return self.imageViewContainer.widthLayoutConstraint(self.imageViewWidth)
    }()
    
    ///
    private lazy var accessoryViewwidthLayoutConstraint: NSLayoutConstraint = {
        return self.accessoryViewContainer.widthLayoutConstraint(self.accessoryViewWidth)
    }()
    
    ///
    private lazy var panGesture: UIPanGestureRecognizer = {
        return UIPanGestureRecognizer(target: self, action: #selector(didRecognizePanGesture(_:)))
    }()
    
    // MARK: - ** Constructor Methods **

    // MARK: - ** UIView **

    public override func drawRect(rect: CGRect) {

        super.drawRect(rect)

        if let view = _westView {
            westViewContainer.addSubview(view)
            view.constrainToSuperview()
        }
        if let view = _mainView {
            mainViewContainer.addSubview(view)
            view.constrainToSuperview()
        }
        if let view = _eastView {
            eastViewContainer.addSubview(view)
            view.constrainToSuperview()
        }

        if let view = _imageView {
            imageViewContainer.addSubview(view)
            view.constrainToSuperview()
        }
        if let view = _accessoryView {
            accessoryViewContainer.addSubview(view)
            view.constrainToSuperview()
        }

        westViewContainer.translatesAutoresizingMaskIntoConstraints = false
        mainViewContainer.translatesAutoresizingMaskIntoConstraints = false
        eastViewContainer.translatesAutoresizingMaskIntoConstraints = false

        imageViewContainer.translatesAutoresizingMaskIntoConstraints = false
        accessoryViewContainer.translatesAutoresizingMaskIntoConstraints = false
    
        contentView.addSubview(westViewContainer)
        contentView.addSubview(mainViewContainer)
        contentView.addSubview(eastViewContainer)

        contentView.addSubview(imageViewContainer)
        contentView.addSubview(accessoryViewContainer)

        westViewContainer.addConstraint(westViewwidthLayoutConstraint)
        eastViewContainer.addConstraint(eastViewwidthLayoutConstraint)

        imageViewContainer.addConstraint(imageViewwidthLayoutConstraint)
        accessoryViewContainer.addConstraint(accessoryViewwidthLayoutConstraint)

        contentView.addConstraint(westViewOffsetLayoutConstraint)
        contentView.addConstraint(westViewContainer.topLayoutConstraintRelativeToView(contentView))
        contentView.addConstraint(westViewContainer.bottomLayoutConstraintRelativeToView(contentView))

        contentView.addConstraint(imageViewOffsetLayoutConstraint)

        contentView.addConstraint(imageViewContainer.centerYLayoutConstraintRelativeToView(contentView))
        contentView.addConstraint(mainViewLeftPaddingLayoutConstraint)

        contentView.addConstraint(mainViewContainer.topLayoutConstraintRelativeToView(contentView))
        contentView.addConstraint(mainViewContainer.bottomLayoutConstraintRelativeToView(contentView))
        contentView.addConstraint(mainViewRightPaddingLayoutConstraint)

        contentView.addConstraint(accessoryViewContainer.centerYLayoutConstraintRelativeToView(contentView))
        contentView.addConstraint(accessoryViewContainer.heightLayoutConstraintRelativeToView(contentView))
        contentView.addConstraint(accessoryViewOffsetLayoutConstraint)

        contentView.addConstraint(eastViewContainer.topLayoutConstraintRelativeToView(contentView))
        contentView.addConstraint(eastViewContainer.bottomLayoutConstraintRelativeToView(contentView))
        contentView.addConstraint(eastViewOffsetLayoutConstraint)

        addGestureRecognizers()

    }

    // MARK: - ** Private Methods **
    
    ///
    private func addGestureRecognizers() {
        addPanGestureRecognizer()
    }
    
    ///
    private func addPanGestureRecognizer() {
        if let gestureRecognizers = gestureRecognizers {
            if !gestureRecognizers.contains(panGesture) {
                addGestureRecognizer(panGesture)
                return
            }
        }
        addGestureRecognizer(panGesture)
    }
    
    ///
    private func animateLayoutChanges(duration: NSTimeInterval = 0.0, completion: (() -> Void)? = nil) {
        UIView.animateWithDuration(duration, animations :
            { () -> Void in
                self.layoutIfNeeded()
            })
        { (Bool) -> Void in
            completion?()
        }
    }
    
    ///
    private func showWestView(animated: Bool = true) {
        if !sideViewsEnabled || !westViewEnabled || _westView == nil {
            return
        }
        delegate?.swipeTableViewCell(self, willShowSideView: westView)
        westViewWidth = maxWestWidth
        eastViewOffset = maxEastWidth
        animateLayoutChanges(animated ? 0.2: 0.0)
        { () -> Void in
            self.westViewVisible = true
            self.delegate?.swipeTableViewCell(self, didShowSideView: self.westView)
        }
    }
    
    ///
    private func showEastView(animated: Bool = true) {
        if !sideViewsEnabled || !eastViewEnabled || _eastView == nil {
            return
        }
        delegate?.swipeTableViewCell(self, willShowSideView: eastView)
        eastViewWidth = maxEastWidth
        westViewOffset = -maxEastWidth
        animateLayoutChanges(animated ? 0.2: 0.0)
        { () -> Void in
            self.eastViewVisible = true
            self.delegate?.swipeTableViewCell(self, didShowSideView: self.eastView)
        }
    }
    
    ///
    private func hideWestView(animated: Bool = true) {
        westViewWidth = 0.0
        eastViewOffset = 0.0
        animateLayoutChanges(animated ? 0.2: 0.0)
        { () -> Void in
            self.westViewVisible = false
        }
    }
    
    ///
    private func hideEastView(animated: Bool = true) {
        eastViewWidth = 0.0
        westViewOffset = 0.0
        animateLayoutChanges(animated ? 0.2: 0.0)
        { () -> Void in
            self.eastViewVisible = false
        }
    }
    
    ///
    public func hideAllViews(animated: Bool = true) {
        hideWestView(animated)
        hideEastView(animated)
    }
    
    // MARK: - ** -- **
    
    ///
    public func didRecognizePanGesture(gesture: UIPanGestureRecognizer) {

        if !sideViewsEnabled {
            return
        }

        delegate?.swipeTableViewCell(self, didRecognizePanGesture: gesture)

        let translation = gesture.translationInView(self)

        let width = abs(translation.x)

        if translation.x < 0 {

            hideWestView()
            if _eastView != nil && eastViewEnabled && !eastViewVisible {
                eastViewWidth = width > maxEastWidth ? maxEastWidth: width
                westViewOffset = -width
            }

        } else if translation.x > 0 {

            hideEastView()
            if _westView != nil && westViewEnabled && !westViewVisible {
                westViewWidth = width > maxWestWidth ? maxWestWidth: width
                eastViewOffset = width
            }

        }

        animateLayoutChanges()

        if gesture.state == .Ended {

            if translation.x < 0 && width > minEastWidth {
                showEastView()
            } else if translation.x > 0 && width > minWestWidth {
                showWestView()
            } else {
                hideAllViews()
            }

        }

    }
    
    ///
    private func westViewDidRecognizeSingleTapGesture(gesture: UITapGestureRecognizer) {

    }
    
    ///
    private func mainViewDidRecognizeSingleTapGesture(gesture: UITapGestureRecognizer) {
        hideAllViews()
    }
    
    ///
    private func eastViewDidRecognizeSingleTapGesture(gesture: UITapGestureRecognizer) {

    }
    
    // MARK: -
    
    ///
    @objc
    private func toolbarItemClicked(barButtonItem: UIBarButtonItem) {
        guard let index = accessoryToolbar?.items?.indexOf(barButtonItem) else { return }
        delegate?.swipeTableViewCell(self, didPressToolbarItem: barButtonItem, atIndex: index)
    }

    
    /// The default implementation that includes a title label, a subtitle
    /// label, and a delete button
    public class Deletable : NBSwipeTableViewCell {
        
        ///
        public var title: String? {
            didSet { titleLabel.text = title }
        }
        
        ///
        public var subtitle: String? {
            didSet {
                guard let subtitle = subtitle else { return }
                subtitleHeight = (subtitle.length > 0 ? 10.0: 0.0)
                subtitleLabel.text = subtitle
            }
        }
        
        ///
        public var detailSubtitle: String? {
            didSet {
                guard let _ = detailSubtitle else { return }
                detailSubtitleWidth = 100.0
                detailSubtitleLabel.text = detailSubtitle
            }
        }
        
        ///
        public var deleteButtonTitle: String = "Delete" {
            didSet { 
                deleteButton.setTitle(deleteButtonTitle, forState: .Normal) 
            }
        }
        
        ///
        private var subtitleHeight: CGFloat = 0.0
        ///
        private var detailSubtitleWidth: CGFloat = 100.0 {
            didSet {
                detailSubtitleLabelWidthConstraint.constant = detailSubtitleWidth
            }
        }
        
        ///
        private lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = self.title
            label.adjustsFontSizeToFitWidth = true
            return label
        }()
        
        ///
        private lazy var subtitleLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = self.subtitle
            label.font = UIFont.systemFontOfSize(10.0)
            return label
        }()
        
        ///
        private lazy var detailSubtitleLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = self.detailSubtitle
            label.font = UIFont.systemFontOfSize(10.0)
            label.textAlignment = .Right
            label.textColor = .grayColor()
            return label
        }()
        
        ///
        private lazy var deleteButton: UIButton = {
            
            let deleteButton = UIButton()
            
            deleteButton.contentEdgeInsets = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 10.0)
            
            deleteButton.setTitle(self.deleteButtonTitle, forState: .Normal)
            deleteButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            deleteButton.sizeToFit()
            
            deleteButton.addTarget(self, 
                                   action: #selector(deleteButtonClicked(_:)), 
                                   forControlEvents: .TouchUpInside)
            
            return deleteButton
            
        }()
        
        ///
        private lazy var subtitleLabelHeightConstraint: NSLayoutConstraint = {
            return self.subtitleLabel.heightLayoutConstraint(self.subtitleHeight)
        }()
        
        ///
        private lazy var detailSubtitleLabelWidthConstraint: NSLayoutConstraint = {
            return self.detailSubtitleLabel.widthLayoutConstraint(self.detailSubtitleWidth)
        }()

        public override func drawRect(rect: CGRect) {

            super.drawRect(rect)

            let mview = UIView()

            mview.addSubview(titleLabel)
            mview.addSubview(subtitleLabel)
            mview.addSubview(detailSubtitleLabel)

            subtitleLabel.addConstraint(subtitleLabelHeightConstraint)
            detailSubtitleLabel.addConstraint(detailSubtitleLabelWidthConstraint)

            mview.addConstraint(titleLabel.leftLayoutConstraintRelativeToView(mview))
            mview.addConstraint(titleLabel.topLayoutConstraintRelativeToView(mview))
            mview.addConstraint(titleLabel.rightLayoutConstraintRelativeToView(mview))

            mview.addConstraint(titleLabel.verticalSpacingLayoutConstraintRelativeToView(subtitleLabel))

            mview.addConstraint(subtitleLabel.leftLayoutConstraintRelativeToView(mview))
            mview.addConstraint(subtitleLabel.bottomLayoutConstraintRelativeToView(mview))

            mview.addConstraint(subtitleLabel.horizontalSpacingLayoutConstraintRelativeToView(detailSubtitleLabel))

            mview.addConstraint(detailSubtitleLabel.heightLayoutConstraintRelativeToView(subtitleLabel))
            mview.addConstraint(detailSubtitleLabel.rightLayoutConstraintRelativeToView(mview))
            mview.addConstraint(detailSubtitleLabel.bottomLayoutConstraintRelativeToView(mview))
            
            mainView = mview

            let eview = UIView()
            eview.backgroundColor = .redColor()

            eview.addSubview(deleteButton)
            deleteButton.constrainToSuperview()

            eastView = eview
            maxEastWidth = deleteButton.width
            
        }
        
        ///
        @objc
        private func deleteButtonClicked(sender: UIButton) {
            delegate?.swipeTableViewCellDidPressDelete(self)
        }
        
    }
    
}

