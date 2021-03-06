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

/// 
public func == (lhs: PKPopoverAction, rhs: PKPopoverAction) -> Bool {
    return lhs.rawValue == rhs.rawValue
}

/// 
public struct PKPopoverAction : OptionSet, Hashable {
        
    public typealias RawValue = Int
    
    public var rawValue: RawValue = 0
    
    /// 
    public static let `default`: PKPopoverAction = [.cancel, .done]
    
    /// 
    public static let cancel = PKPopoverAction(1 << 0)
    
    /// 
    public static let apply = PKPopoverAction(1 << 1)
    
    /// 
    public static let done = PKPopoverAction(1 << 2)
    
    /// 
    public static let reverse = PKPopoverAction(1 << 10)
    
    public var hashValue: Int {
        return rawValue.hashValue
    }
    
    public init(rawValue: RawValue) {
        self.rawValue = rawValue
    }
    
    /// 
    public init(_ rawValue: RawValue) {
        self.init(rawValue: rawValue)
    }
    
}

/// 
public protocol PKPopoverPresentationControllerDelegate : UIPopoverPresentationControllerDelegate {
    
    /// 
    func present(_ viewController: UIViewController, animated flag: Bool, completion: (() -> Void)?)
    
    /// 
    
    func popoverPresentationController(_ popoverPresentationController: PKPopoverPresentationController, didRequestAction action: PKPopoverAction, userInfo: Any?, responder: Any?)
    
    /// 
    func popoverPresentationControllerDidResign(_ popoverPresentationController: PKPopoverPresentationController)
    
}

/// 
extension PKPopoverPresentationControllerDelegate {
    
    /// 
    public func popoverPresentationController(_ popoverPresentationController: PKPopoverPresentationController, didRequestAction action: PKPopoverAction, userInfo: Any?, responder: Any?) {}
    
    /// 
    public func popoverPresentationControllerDidResign(_ popoverPresentationController: PKPopoverPresentationController) {}
    
}

///
open class PKPopoverPresentationController : UIViewController, UIPopoverPresentationControllerDelegate {
    
    /// 
    open static let DidUpdateUserInfoNotification = "PKPopoverPresentationControllerDidUpdateUserInfoNotification"
    
    /// 
    open weak var delegate: PKPopoverPresentationControllerDelegate?
    
    /// 
    open weak var responder: AnyObject?
    
    /// 
    open var name: String! = ""
    
    /// 
    open var actions: PKPopoverAction = [.done] {
        didSet { updateActions() }
    }
    
    /// 
    open var overrideDimiss: Bool = false
    
    /// 
    open var actionTitles: [PKPopoverAction : String] = [
            .cancel : LocalizedStrings.cancel,
            .apply  : LocalizedStrings.apply,
            .done   : LocalizedStrings.done,
        ] {
        didSet { updateActions() }
    }
    
    /// 
    open var actionsEnabled: [PKPopoverAction : Bool] = [
            .cancel : true,
            .apply  : false,
            .done   : true,
            ] {
        didSet { updateActions() }
    }
    
    /// 
    open var userInfo: Any?
    
    // MARK: - Private Properties
    
    /// 
    fileprivate lazy var cancelButton: UIBarButtonItem = {
        let cancelButton = UIBarButtonItem(
            title: self.actionTitles[.cancel],
            target: self,
            action: #selector(didPressCancelBarButtonItem(_:)))
        cancelButton.isEnabled = self.actionsEnabled[.cancel] ?? false
        return cancelButton
    }()
    
    /// 
    fileprivate lazy var applyButton: UIBarButtonItem = {
        let applyButton = UIBarButtonItem(
            title: self.actionTitles[.apply],
            target: self, 
            action: #selector(didPressApplyBarButtonItem(_:)))
        applyButton.isEnabled = self.actionsEnabled[.apply] ?? false
        return applyButton
    }()
    
    /// 
    fileprivate lazy var doneButton: UIBarButtonItem = {
        let doneButton = UIBarButtonItem(
            title: self.actionTitles[.done], 
            target: self, 
            action: #selector(didPressDoneBarButtonItem(_:)))
        doneButton.isEnabled = self.actionsEnabled[.done] ?? false
        return doneButton
    }()
    
    // MARK: - Constuctors
    
    /// 
    public convenience init(view: UIView?, responder: AnyObject?) {
        self.init()
        if let view = view {
            self.view.addSubview(view)
            view.constrainToSuperview()
        }
        self.responder = responder
    }
    
    // MARK: UIViewController Methods
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        updateActions()
        beginObservations()
    }
    
    /// 
    open func updateActions() {
        
        navigationItem.leftBarButtonItems = nil
        navigationItem.rightBarButtonItem = nil
        
        if actions.contains(.cancel) {
            cancelButton.title = actionTitles[.cancel]
            if actions.contains(.reverse) {
                navigationItem.rightBarButtonItem = cancelButton
            } else { navigationItem.leftBarButtonItem = cancelButton }
        }
        
        var items = [UIBarButtonItem]()
        
        if actions.contains(.done) {
            doneButton.title = actionTitles[.done]
            items.append(doneButton)
        }
        
        if actions.contains(.apply) {
            applyButton.title = actionTitles[.apply]
            items.append(applyButton)
        }
        
        if actions.contains(.reverse) {
            navigationItem.leftBarButtonItems = items
        } else { navigationItem.rightBarButtonItems = items }
        
    }
    
    /// 
    open func beginObservations() {
        
        beginObserving(
            selector: #selector(didUpdateUserInfo(_:)), 
            name: PKPopoverPresentationController.DidUpdateUserInfoNotification, 
            object: userInfo)
        
    }
    
    /// 
    open func presentWithDelegate(_ delegate: PKPopoverPresentationControllerDelegate, barButtonItem: UIBarButtonItem? = nil, completion: (() -> Void)? = nil) {
        
        let nav = embeddedInsideNavigationController()
        nav.modalPresentationStyle = .popover
        
        delegate.present(nav, animated: true) { () -> Void in
            completion?()
        }
        
        self.delegate = delegate
        
        guard UIDevice.splitViewSupported(), let controller = navigationController?.popoverPresentationController else { return }
        
        controller.permittedArrowDirections = .any
        controller.barButtonItem = barButtonItem
        
    }
    
    /// 
    open func dismiss(_ completion: (() -> Void)? = nil) {
        navigationController?.dismiss(animated: true) { () -> Void in
            completion?()
            self.delegate?.popoverPresentationControllerDidResign(self)
        }
    }
    
    // MARK: - Private Methods
    
    // MARK: - Action Handlers
    
    @objc
    /// 
    fileprivate func didPressCancelBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        delegate?.popoverPresentationController(self, didRequestAction: [.cancel], userInfo: userInfo, responder: responder)
        dismiss()
    }
    
    @objc
    /// 
    fileprivate func didPressApplyBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        delegate?.popoverPresentationController(self, didRequestAction: [.apply], userInfo: userInfo, responder: responder)
    }
    
    @objc
    /// 
    fileprivate func didPressDoneBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        delegate?.popoverPresentationController(self, didRequestAction: [.apply, .done], userInfo: userInfo, responder: responder)
        if !overrideDimiss { dismiss() }
    }
    
    // MARK: - Notification Handlers
    
    @objc
    /// 
    fileprivate func didUpdateUserInfo(_ notification: Notification) {
        updateActions()
    }

    
}
