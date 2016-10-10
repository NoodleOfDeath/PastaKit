//
//  StringOptionSetType.swift
//  NoodleBox
//
//  Created by Thom Morgan on 9/12/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import Foundation

public protocol Separable : Hashable {
    func separatedComponents() -> [Self]
}

extension String : Separable {}

extension String {
    public func separatedComponents() -> [String] {
        return components(separatedBy: .whitespaces())
    }
}

/// 
public protocol SeparableOptionSetType : OptionSet {
    
    /// 
    associatedtype Key: Separable
    /// 
    static var values: [Key : Element] { get }
    
    /// 
    init(rawValue: RawValue)
    /// 
    init(_ rawValue: RawValue)
    
    /// 
    init(key: Key?)
    /// 
    init(_ key: Key?)
    
    /// 
    init(keys: [Key]?)
    /// 
    init(_ keys: [Key]?)
    
}

extension SeparableOptionSetType {
    
    public init(_ rawValue: RawValue) {
        self.init(rawValue: rawValue)
    }
    
    public init(key: Key?) {
        self.init(keys: key?.separatedComponents())
    }
    
    public init(_ key: Key?) {
        self.init(key: key)
    }
    
    public init(keys: [Key]?) {
        self.init()
        guard let keys = keys else { return }
        for key in keys {
            guard let element = Self.values[key] else { continue }
            insert(element)
        }
    }
    
    public init(_ keys: [Key]?) {
        self.init(keys: keys)
    }
    
}

