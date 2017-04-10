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

extension UIDevice {
    
    open static var isPortrait: Bool {
        return UIDeviceOrientationIsPortrait(current.orientation)
    }
    
    open static var isFlat: Bool {
        return current.orientation.isFlat
    }
    
    open static var isLandscape: Bool {
        return UIDeviceOrientationIsLandscape(current.orientation)
    }
    
    open static var isValidInterfaceOrientation: Bool {
        return UIDeviceOrientationIsValidInterfaceOrientation(current.orientation)
    }
    
    open static var isPortraitOrFlat: Bool {
        return isPortrait || isFlat
    }

    open static func isIphone4orLess() -> Bool {
        return current.userInterfaceIdiom == .phone
            && UIScreen.maxDimension() < 568.0
    }

    open static func isIphone5() -> Bool {
        return current.userInterfaceIdiom == .phone
            && UIScreen.maxDimension() == 568.0
    }

    open static func isIphone6() -> Bool {
        return current.userInterfaceIdiom == .phone
            && UIScreen.maxDimension() == 667.0
    }

    open static func isIphone6P() -> Bool {
        return current.userInterfaceIdiom == .phone
            && UIScreen.maxDimension() == 736.0
    }

    open static func isIpad() -> Bool {
        return (current.userInterfaceIdiom == .pad)
            && UIScreen.maxDimension() == 1024.0
    }
    
    open static func isIpadPro() -> Bool {
        return (current.userInterfaceIdiom == .pad)
            && UIScreen.maxDimension() == 1366.0
    }

    open static func splitViewSupported() -> Bool {
        return isIpad() || isIpadPro() || isIphone6P()
    }
    
    open static func machine() -> String? {
        return nil
        /*
        var size: size_t = 0
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        guard let _machine = malloc(size) else { return nil }
        sysctlbyname("hw.machine", _machine, &size, nil, 0)
        let data = Data(bytes: UnsafePointer<UInt8>(_machine.assumingMemoryBound(to: UInt8.self)), count: Int(size))
        let machine = String(data: data, encoding: String.Encoding.utf8)
        free(_machine)
        return machine*/
    }

}
