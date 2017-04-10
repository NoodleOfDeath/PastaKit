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

extension UIViewController {
    
    /// 
    open var ordinal: Int {
        guard let index = navigationController?.viewControllers.index(of: self) else { return NSNotFound }
        return index
    }
    
    /// 
    open var isRootViewController: Bool {
        return ordinal == 0
    }

    /// Sets the text for the back button in the navigation controller.
    open var backButtonTitle: String? {
        get {
            guard let button = navigationItem.backBarButtonItem else { return nil }
            return button.title
        }
        set {
            navigationItem.backBarButtonItem = UIBarButtonItem(title: newValue)
        }
    }
    
    /// 
    open func embeddedInsideNavigationController() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }

}
