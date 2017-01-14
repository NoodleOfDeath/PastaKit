//
// CountableRange.swift
// NoodleBox
//
// Created by Thom Morgan on 10/10/16.
// Copyright © 2016 NoodleNation. All rights reserved.
//

import Foundation

/// 
extension CountableRange where Bound : Integer {
    
    ///
    public var length: Bound { return upperBound - lowerBound }
    
}
