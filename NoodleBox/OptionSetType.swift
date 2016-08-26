//
//  OptionSetType.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 6/30/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import Foundation

public func + <T: OptionSetType>(lhs: T, rhs: T) -> T {
    return lhs.union(rhs)
}

extension OptionSetType {
    
    public func without(member: Element) -> Self {
        var set = self
        set.remove(member)
        return set
    }
    
    public func doesNotContain(element: Element) -> Bool {
        return !contains(element)
    }
    
    
    
}