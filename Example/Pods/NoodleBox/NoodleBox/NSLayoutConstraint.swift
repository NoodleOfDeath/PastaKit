//
// NSLayoutConstaint.swift
// NoodleBox
//
// Created by NoodleOfDeath on 2/28/16.
// Copyright © 2016 NoodleNation. All rights reserved.
//

import UIKit

// MARK: - ** NSLayoutConstraint Extension **
extension NSLayoutConstraint {

    public convenience init(item view1: Any, attribute attr: NSLayoutAttribute, relatedBy relation: NSLayoutRelation = .equal, toItem view2: Any?, multiplier m: CGFloat = 1.0, constant c: CGFloat = 0.0) {
        self.init(item: view1, attribute: attr, relatedBy: .equal, toItem: view2, attribute: attr, multiplier: m, constant: c)
    }

    public convenience init(item view1: Any, attribute attr1: NSLayoutAttribute, toItem view2: Any?, attribute attr2: NSLayoutAttribute, multiplier m: CGFloat = 1.0, constant c: CGFloat = 0.0) {
        self.init(item: view1, attribute: attr1, relatedBy: .equal, toItem: view2, attribute: attr2, multiplier: m, constant: c)
    }

}
