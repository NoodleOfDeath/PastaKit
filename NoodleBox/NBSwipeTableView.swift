//
//  NBSwipeTableView.swift
//  ByteMe
//
//  Created by Thom Morgan on 6/10/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import UIKit

///
public class NBSwipeTableView : UITableView, UIGestureRecognizerDelegate {
    
    ///
    public var initialContentOffset = CGPointZero
    
    ///
    private var viewLoaded = false
    
    ///
    public override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        if !viewLoaded {
            viewLoaded = true
            contentOffset = initialContentOffset
        }
    }
    
    ///
    public func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}