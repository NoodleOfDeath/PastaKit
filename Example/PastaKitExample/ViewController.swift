//
//  ViewController.swift
//  NoodleBoxExample
//
//  Created by Thom Morgan on 9/2/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import UIKit

import NoodleBox

class ViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .whiteColor()
        
        let innerView = UIView()
        innerView.backgroundColor = .blueColor()
        
        // This must be called on every subview being constrained
        // when programmatically setting layout constraints
        innerView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(innerView)
        
        view.addConstraint(innerView.topLayoutConstraintRelativeToView(view, constant: 10.0))
        view.addConstraint(innerView.leftLayoutConstraintRelativeToView(view, constant: 10.0))
        view.addConstraint(innerView.bottomLayoutConstraintRelativeToView(view, constant: -10.0))
        view.addConstraint(innerView.rightLayoutConstraintRelativeToView(view, constant: -10.0))
        
        let topInnerView = UIView()
        let bottomInnerView = UIView()
        
        topInnerView.backgroundColor = .redColor()
        bottomInnerView.backgroundColor = .greenColor()
        
        topInnerView.translatesAutoresizingMaskIntoConstraints = false
        bottomInnerView.translatesAutoresizingMaskIntoConstraints = false
        
        innerView.addSubview(topInnerView)
        innerView.addSubview(bottomInnerView)
        
        innerView.addConstraint(topInnerView.heightLayoutConstraintRelativeToView(innerView, multiplier: 0.5))
        
        innerView.addConstraint(topInnerView.topLayoutConstraintRelativeToView(innerView))
        innerView.addConstraint(topInnerView.leftLayoutConstraintRelativeToView(innerView))
        innerView.addConstraint(topInnerView.rightLayoutConstraintRelativeToView(innerView))
        
        innerView.addConstraint(topInnerView.verticalSpacingLayoutConstraintRelativeToView(bottomInnerView))
        
        innerView.addConstraint(bottomInnerView.leftLayoutConstraintRelativeToView(innerView))
        innerView.addConstraint(bottomInnerView.bottomLayoutConstraintRelativeToView(innerView))
        innerView.addConstraint(bottomInnerView.rightLayoutConstraintRelativeToView(innerView))
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}

