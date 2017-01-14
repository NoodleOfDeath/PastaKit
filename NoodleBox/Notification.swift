//
// Notification.swift
// NoodleBox
//
// Created by Thom Morgan on 10/11/16.
// Copyright © 2016 NoodleNation. All rights reserved.
//

import Foundation

public func == <T: Equatable>(lhs: Notification.Name, rhs: T) -> Bool {
    guard lhs is T else { return false }
    return (lhs as? T) == rhs
}
