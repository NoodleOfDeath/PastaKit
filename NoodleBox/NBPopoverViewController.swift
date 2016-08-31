//
//  NBPopoverViewController.swift
//  NoodleForm
//
//  Created by NoodleOfDeath on 6/10/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import UIKit

public let NBPopoverViewControllerDidUpdateUserInfoNotification = "NBPopoverViewControllerDidUpdateUserInfoNotification"

public func == (lhs: NBPopoverAction, rhs: NBPopoverAction) -> Bool {
    return lhs.rawValue == rhs.rawValue
}

public struct NBPopoverAction : OptionSetType, Hashable {
    
    public typealias DynamicType = NBPopoverAction
    public typealias RawValue = Int
    
    public var rawValue: RawValue = 0
    
    public static let Default: DynamicType = [.Cancel, .Done]
    
    public static let Cancel   = DynamicType(1 << 0)
    public static let Apply    = DynamicType(1 << 1)
    public static let Done     = DynamicType(1 << 2)
    
    public static let Reversed = DynamicType(1 << 10)
    
    public var hashValue: Int {
        return rawValue.hashValue
    }
    
    public init(rawValue: RawValue) {
        self.rawValue = rawValue
    }
    
    public init(_ rawValue: RawValue) {
        self.init(rawValue: rawValue)
    }
    
}

public protocol NBPopoverViewControllerDelegate : UIPopoverPresentationControllerDelegate {
    func presentViewController(viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
    func popoverViewController(popoverViewController: NBPopoverViewController, didRequestAction: NBPopoverAction, userInfo: AnyObject?, responder: AnyObject?)
    func popoverViewControllerDidResign(popoverViewController: NBPopoverViewController)
}

extension NBPopoverViewControllerDelegate {
    public func popoverViewController(popoverViewController: NBPopoverViewController, didRequestAction: NBPopoverAction, userInfo: AnyObject?, responder: AnyObject?) {}
    public func popoverViewControllerDidResign(popoverViewController: NBPopoverViewController) {}
}

extension UIViewController : NBPopoverViewControllerDelegate {}

// MARK: - ** NBPopoverViewController Class **

///
public class NBPopoverViewController: UIViewController {
    
    public weak var delegate: NBPopoverViewControllerDelegate?
    
    // MARK: - ** Get-Only Properties **
    
    public var name: String! = ""
    
    public weak var responder: AnyObject?
    
    public var actions: NBPopoverAction = [.Done] {
        didSet { updateActions() }
    }
    
    public var overrideDimiss: Bool = false
    
    public var actionTitles: [NBPopoverAction : String] = [
            .Cancel : LSCancel,
            .Apply  : LSApply,
            .Done   : LSDone,
        ] {
        didSet { updateActions() }
    }
    
    public var actionsEnabled: [NBPopoverAction : Bool] = [
            .Cancel : true,
            .Apply  : false,
            .Done   : true,
            ] {
        didSet { updateActions() }
    }
    
    public var userInfo: AnyObject?
    
    // MARK: - ** Private Properties **
    
    private lazy var cancelButton: UIBarButtonItem = {
        let cancelButton = UIBarButtonItem(
            title: self.actionTitles[.Cancel],
            target: self,
            action: #selector(didPressCancelBarButtonItem(_:)))
        cancelButton.enabled = self.actionsEnabled[.Cancel] ?? false
        return cancelButton
    }()
    
    private lazy var applyButton: UIBarButtonItem = {
        let applyButton = UIBarButtonItem(
            title: self.actionTitles[.Apply],
            target: self, 
            action: #selector(didPressApplyBarButtonItem(_:)))
        applyButton.enabled = self.actionsEnabled[.Apply] ?? false
        return applyButton
    }()
    
    private lazy var doneButton: UIBarButtonItem = {
        let doneButton = UIBarButtonItem(
            title: self.actionTitles[.Done], 
            target: self, 
            action: #selector(didPressDoneBarButtonItem(_:)))
        doneButton.enabled = self.actionsEnabled[.Done] ?? false
        return doneButton
    }()
    
    // MARK: - ** Superclass/Protocol Methods **
    
    public convenience init(view: UIView?, responder: AnyObject?) {
        self.init()
        if let view = view {
            self.view.addSubview(view)
            view.constrainToSuperview()
        }
        self.responder = responder
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        updateActions()
        beginObservations()
    }
    
    // MARK: - ** Internal Methods **
    
    public func updateActions() {
        
        navigationItem.leftBarButtonItems = nil
        navigationItem.rightBarButtonItem = nil
        
        if actions.contains(.Cancel) {
            cancelButton.title = actionTitles[.Cancel]
            if actions.contains(.Reversed) {
                navigationItem.rightBarButtonItem = cancelButton
            } else { navigationItem.leftBarButtonItem = cancelButton }
        }
        
        var items = [UIBarButtonItem]()
        
        if actions.contains(.Done) {
            doneButton.title = actionTitles[.Done]
            items.append(doneButton)
        }
        
        if actions.contains(.Apply) {
            applyButton.title = actionTitles[.Apply]
            items.append(applyButton)
        }
        
        if actions.contains(.Reversed) {
            navigationItem.leftBarButtonItems = items
        } else { navigationItem.rightBarButtonItems = items }
        
    }
    
    public func beginObservations() {
        
        beginObserving(
            selector: #selector(didUpdateUserInfo(_:)), 
            name: NBPopoverViewControllerDidUpdateUserInfoNotification, 
            object: userInfo)
        
    }
    
    public func presentWithDelegate(delegate: NBPopoverViewControllerDelegate, barButtonItem: UIBarButtonItem? = nil, completion: (() -> Void)? = nil) {
        
        self.delegate = delegate
        
        let nav = embeddedInsideNavigationController()
        nav.modalPresentationStyle = .Popover
        
        delegate.presentViewController(nav, animated: true) { () -> Void in
            completion?()
        }
        
        guard UIDevice.splitViewSupported(), let controller = navigationController?.popoverPresentationController else { return }
        
        controller.permittedArrowDirections = .Any
        controller.barButtonItem = barButtonItem
        controller.delegate = delegate
        
    }
    
    public func dismiss(completion: (() -> Void)? = nil) {
        navigationController?.dismissViewControllerAnimated(true) { () -> Void in
            completion?()
            self.delegate?.popoverViewControllerDidResign(self)
        }
    }
    
    // MARK: - ** Private Methods **
    
    // MARK: - ** Action Handlers **
    
    @objc
    private func didPressCancelBarButtonItem(barButtonItem: UIBarButtonItem) {
        delegate?.popoverViewController(self, didRequestAction: [.Cancel], userInfo: userInfo, responder: responder)
        dismiss()
    }
    
    @objc
    private func didPressApplyBarButtonItem(barButtonItem: UIBarButtonItem) {
        delegate?.popoverViewController(self, didRequestAction: [.Apply], userInfo: userInfo, responder: responder)
    }
    
    @objc
    private func didPressDoneBarButtonItem(barButtonItem: UIBarButtonItem) {
        delegate?.popoverViewController(self, didRequestAction: [.Apply, .Done], userInfo: userInfo, responder: responder)
        if !overrideDimiss { dismiss() }
    }
    
    // MARK: - ** Notification Handlers **
    
    @objc
    private func didUpdateUserInfo(notification: NSNotification) {
        updateActions()
    }

    
}
