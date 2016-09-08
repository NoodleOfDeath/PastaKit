//
//  BMSwipeTableView.swift
//  ByteMe
//
//  Created by Thom Morgan on 6/10/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import UIKit
import NoodleBox

///
class BMSwipeTableView : UITableView, UIGestureRecognizerDelegate {
    
    var initialContentOffset = CGPointZero
    
    private var viewLoaded = false
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        if !viewLoaded {
            viewLoaded = true
            contentOffset = initialContentOffset
        }
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}