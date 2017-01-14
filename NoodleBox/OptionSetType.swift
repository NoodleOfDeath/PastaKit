//
// OptionSetType.swift
// NoodleBox
//
// Created by NoodleOfDeath on 6/30/16.
// Copyright © 2016 NoodleNation. All rights reserved.
//

import Foundation

public func + <T: OptionSet>(lhs: T, rhs: T) -> T {
    return lhs.union(rhs)
}

extension OptionSet {
    
    public func without(_ member: Element) -> Self {
        var set = self
        set.remove(member)
        return set
    }
    
    public func doesNotContain(_ element: Element) -> Bool {
        return !contains(element)
    }
    
    
    
}
