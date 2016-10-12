//
//  MultitouchTableView.swift
//  NoodleBox
//
//  Created by Thom Morgan on 10/12/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import Foundation

open class MultitouchTableView : UITableView, UIGestureRecognizerDelegate {
    
    open func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith: UIGestureRecognizer) -> Bool {
        return true
    }
    
}
