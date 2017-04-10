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

extension UIApplication {
    
    /// The orientation of the application in terms of the status
    /// bar orientation.
    /// - note: This is not necessarily the device orientation.
    /// - returns: The orientation of the application in terms of the
    /// status bar orientation.
    /// - seealso: [`UIDeviceOrientation`]()
    open static var orientation: UIInterfaceOrientation {
        return shared.statusBarOrientation
    }
    
    /// `true` if the `orientation` is either `.Portrait` or
    /// `.PortraitUpsideDown`
    open static var isPortrait: Bool {
        return orientation.isPortrait
    }

    /// `true` if the `orientation` is either `.LandscapeLeft` or
    /// `.LandscapeRight`
    open static var isLandscape: Bool {
        return orientation.isLandscape
    }
    
    /// The shared application delegate
    /// - returns: The shared application delegate
    open static func sharedDelegate() -> UIApplicationDelegate? {
        return shared.delegate
    }

    /// The shared application key window
    /// - returns: The shared application key window
    open static func sharedKeyWindow() -> UIWindow? {
        return shared.keyWindow
    }
    
    /// Dismiss keyboard from key window.
    open static func endEditing(_ force: Bool = false) {
        shared.keyWindow?.endEditing(force)
    }

}
