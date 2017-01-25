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

// MARK: - NSLayoutConstraint Convenience Constructors -
extension NSLayoutConstraint {

    /// Creates a constraint that defines the relationship between the specified attributes of the given views.
    ///
    /// Constraints represent linear equations of the form `view1.attr <relation> multiplier × view2.attr + c`. If the constraint you wish to express does not have a second view and attribute, use `nil` and `notAnAttribute`.
    /// - note:
    /// This method throws an invalidArgumentException exception if it is used to create an invalid constraint (for example, `view1.top == 0.0 x nil.NotAnAttribute + 200.0` or `view1.top == 1.0 x view2.height + 20.0`).
    ///
    /// In general, you should use the layout anchor API to programmatically create constraints. This API includes additional type information that can catch many invalid constraints at build time. For more information, see [Creating Constraints Using Layout Anchors](apple-reference-documentation://hsCsDTDolH#1661736) in [NSView](apple-reference-documentation://hsCsDTDolH) or [UIView](apple-reference-documentation://hsdIxI1kkd).
    ///
    /// - parameter view1: The view for the left side of the constraint.
    /// - parameter attr: The attribute of the view for the left and right side of the constraint.
    /// - parameter relation: The relationship between the left side of the constraint and the right side of the constraint. Optional. Default is `.equal`.
    /// - parameter view2: The view for the right side of the constraint. Optional. Omit or specify `nil` if constraint is reflexive.
    /// - parameter multiplier: The constant multiplied with the attribute on the right side of the constraint as part of getting the modified attribute.
    /// - parameter c: The constant added to the multiplied attribute value on the right side of the constraint to yield the final modified attribute.
    /// - returns: A constraint object relating the two provided views with the specified relation, attributes, multiplier, and constant.
    public convenience init(item view1: Any, attribute attr: NSLayoutAttribute, relatedBy relation: NSLayoutRelation = .equal, toItem view2: Any?, multiplier: CGFloat = 1.0, constant c: CGFloat = 0.0) {
        self.init(item: view1, attribute: attr, relatedBy: .equal, toItem: view2, attribute: attr, multiplier: multiplier, constant: c)
    }
    
    /// Creates a constraint that defines the relationship between the specified attributes of the given views.
    ///
    /// Constraints represent linear equations of the form `view1.attr <relation> multiplier × view2.attr + c`. If the constraint you wish to express does not have a second view and attribute, use `nil` and `notAnAttribute`.
    /// - note:
    /// This method throws an invalidArgumentException exception if it is used to create an invalid constraint (for example, `view1.top == 0.0 x nil.NotAnAttribute + 200.0` or `view1.top == 1.0 x view2.height + 20.0`).
    ///
    /// In general, you should use the layout anchor API to programmatically create constraints. This API includes additional type information that can catch many invalid constraints at build time. For more information, see [Creating Constraints Using Layout Anchors](apple-reference-documentation://hsCsDTDolH#1661736) in [NSView](apple-reference-documentation://hsCsDTDolH) or [UIView](apple-reference-documentation://hsdIxI1kkd).
    ///
    /// - parameter view1: The view for the left side of the constraint.
    /// - parameter attr1: The attribute of the view for the left side of the constraint.
    /// - parameter view2: The view for the right side of the constraint. Optional. Omit or specify `nil` if constraint is reflexive.
    /// - parameter attr2: The attribute of the view for the right side of the constraint.
    /// - parameter multiplier: The constant multiplied with the attribute on the right side of the constraint as part of getting the modified attribute.
    /// - parameter c: The constant added to the multiplied attribute value on the right side of the constraint to yield the final modified attribute.
    /// - returns: A constraint object relating the two provided views with the specified relation, attributes, multiplier, and constant.
    public convenience init(item view1: Any, attribute attr1: NSLayoutAttribute, toItem view2: Any?, attribute attr2: NSLayoutAttribute, multiplier: CGFloat = 1.0, constant c: CGFloat = 0.0) {
        self.init(item: view1, attribute: attr1, relatedBy: .equal, toItem: view2, attribute: attr2, multiplier: multiplier, constant: c)
    }

}
