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

public protocol StringEnumeration {
    var rawValue: String { get }
}

extension UITableView {
    
    /// Convenience initializer that omits the initial frame parameter. The
    /// frame is set to `CGRectZero` initially.
    /// - parameter style: A constant that specifies the style of the table 
    /// view. See Table View Style for descriptions of valid constants.
    /// - returns: Returns an initialized `UITableView` object, or `nil` if 
    /// the object could not be successfully initialized.
    public convenience init(style: UITableViewStyle) {
        self.init(frame: CGRect.zero, style: style)
    }
    
    /// Registers a class for use in creating new table cells.
    /// 
    /// Prior to dequeueing any cells, call this method or the register(_:forCellReuseIdentifier:) method to tell the table view how to create new cells. If a cell of the specified type is not currently in a reuse queue, the table view uses the provided information to create a new cell object automatically.
    /// 
    /// If you previously registered a class or nib file with the same reuse identifier, the class you specify in the cellClass parameter replaces the old entry. You may specify nil for cellClass if you want to unregister the class from the specified reuse identifier.
    ///
    /// - parameter cellClass: The class of a cell that you want to use in the table.
    /// - parameter identifier: The reuse identifier for the cell. This parameter must not be nil and must not be an empty string.
    open func register(_ cellClass: Swift.AnyClass?, forCellReuseIdentifier identifier: StringEnumeration) {
        register(cellClass, forCellReuseIdentifier: identifier.rawValue)
    }
    
}
