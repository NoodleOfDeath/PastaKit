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

public func == (lhs: NBPopoverAction, rhs: NBPopoverAction) -> Bool {
    return lhs.rawValue == rhs.rawValue
}

public struct NBPopoverAction : OptionSet, Hashable {
    
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
    func presentViewController(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
    func popoverViewController(_ popoverViewController: NBPopoverViewController, didRequestAction action: NBPopoverAction, userInfo: Any?, responder: Any?)
    func popoverViewControllerDidResign(_ popoverViewController: NBPopoverViewController)
}

extension NBPopoverViewControllerDelegate {
    public func popoverViewController(_ popoverViewController: NBPopoverViewController, didRequestAction action: NBPopoverAction, userInfo: Any?, responder: Any?) {}
    public func popoverViewControllerDidResign(_ popoverViewController: NBPopoverViewController) {}
}

// MARK: - ** NBPopoverViewController Class **

///
open class NBPopoverViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    open static let DidUpdateUserInfoNotification = "NBPopoverViewControllerDidUpdateUserInfoNotification"
    
    open weak var delegate: NBPopoverViewControllerDelegate?
    
    // MARK: - ** Get-Only Properties **
    
    open var name: String! = ""
    
    open weak var responder: AnyObject?
    
    open var actions: NBPopoverAction = [.Done] {
        didSet { updateActions() }
    }
    
    open var overrideDimiss: Bool = false
    
    open var actionTitles: [NBPopoverAction : String] = [
            .Cancel : LocalizedStrings.Cancel,
            .Apply  : LocalizedStrings.Apply,
            .Done   : LocalizedStrings.Done,
        ] {
        didSet { updateActions() }
    }
    
    open var actionsEnabled: [NBPopoverAction : Bool] = [
            .Cancel : true,
            .Apply  : false,
            .Done   : true,
            ] {
        didSet { updateActions() }
    }
    
    open var userInfo: Any?
    
    // MARK: - ** Private Properties **
    
    fileprivate lazy var cancelButton: UIBarButtonItem = {
        let cancelButton = UIBarButtonItem(
            title: self.actionTitles[.Cancel],
            target: self,
            action: #selector(didPressCancelBarButtonItem(_:)))
        cancelButton.isEnabled = self.actionsEnabled[.Cancel] ?? false
        return cancelButton
    }()
    
    fileprivate lazy var applyButton: UIBarButtonItem = {
        let applyButton = UIBarButtonItem(
            title: self.actionTitles[.Apply],
            target: self, 
            action: #selector(didPressApplyBarButtonItem(_:)))
        applyButton.isEnabled = self.actionsEnabled[.Apply] ?? false
        return applyButton
    }()
    
    fileprivate lazy var doneButton: UIBarButtonItem = {
        let doneButton = UIBarButtonItem(
            title: self.actionTitles[.Done], 
            target: self, 
            action: #selector(didPressDoneBarButtonItem(_:)))
        doneButton.isEnabled = self.actionsEnabled[.Done] ?? false
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
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        updateActions()
        beginObservations()
    }
    
    // MARK: - ** Internal Methods **
    
    open func updateActions() {
        
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
    
    open func beginObservations() {
        
        beginObserving(
            selector: #selector(didUpdateUserInfo(_:)), 
            name: NBPopoverViewController.DidUpdateUserInfoNotification, 
            object: userInfo)
        
    }
    
    open func presentWithDelegate(_ delegate: NBPopoverViewControllerDelegate, barButtonItem: UIBarButtonItem? = nil, completion: (() -> Void)? = nil) {
        
        let nav = embeddedInsideNavigationController()
        nav.modalPresentationStyle = .popover
        
        delegate.presentViewController(nav, animated: true) { () -> Void in
            completion?()
        }
        
        self.delegate = delegate
        
        guard UIDevice.splitViewSupported(), let controller = navigationController?.popoverPresentationController else { return }
        
        controller.permittedArrowDirections = .any
        controller.barButtonItem = barButtonItem
        
    }
    
    open func dismiss(_ completion: (() -> Void)? = nil) {
        navigationController?.dismiss(animated: true) { () -> Void in
            completion?()
            self.delegate?.popoverViewControllerDidResign(self)
        }
    }
    
    // MARK: - ** Private Methods **
    
    // MARK: - ** Action Handlers **
    
    @objc
    fileprivate func didPressCancelBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        delegate?.popoverViewController(self, didRequestAction: [.Cancel], userInfo: userInfo, responder: responder)
        dismiss()
    }
    
    @objc
    fileprivate func didPressApplyBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        delegate?.popoverViewController(self, didRequestAction: [.Apply], userInfo: userInfo, responder: responder)
    }
    
    @objc
    fileprivate func didPressDoneBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        delegate?.popoverViewController(self, didRequestAction: [.Apply, .Done], userInfo: userInfo, responder: responder)
        if !overrideDimiss { dismiss() }
    }
    
    // MARK: - ** Notification Handlers **
    
    @objc
    fileprivate func didUpdateUserInfo(_ notification: Notification) {
        updateActions()
    }

    
}
