//
//  NSLayoutConstaint.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 2/28/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import UIKit

// MARK: - ** NSLayoutConstraint Extension **
extension NSLayoutConstraint {

    public convenience init(item view1: AnyObject, attribute attr: NSLayoutAttribute, relatedBy relation: NSLayoutRelation = .Equal, toItem view2: AnyObject?, multiplier m: CGFloat = 1.0, constant c: CGFloat = 0.0) {
        self.init(item: view1, attribute: attr, relatedBy: .Equal, toItem: view2, attribute: attr, multiplier: m, constant: c)
    }

    public convenience init(item view1: AnyObject, attribute attr1: NSLayoutAttribute, toItem view2: AnyObject?, attribute attr2: NSLayoutAttribute, multiplier m: CGFloat = 1.0, constant c: CGFloat = 0.0) {
        self.init(item: view1, attribute: attr1, relatedBy: .Equal, toItem: view2, attribute: attr2, multiplier: m, constant: c)
    }

}
