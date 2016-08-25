//
//  NDLocalizer.swift
//  NoodleBox
//
//  Created by Thom Morgan on 8/18/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation

public struct NDLocalizer {
    
    public static func pluralize(string: String, _ count: Int) -> String {
        return String.localizedStringWithFormat(NSLocalizedString(string, comment: ""), count)
    }
    
    public static func pluralize(string: String, _ count: Double) -> String {
        return String.localizedStringWithFormat(NSLocalizedString(string, comment: ""), count)
    }
    
    public static func pluralize(string: String, _ count: Float) -> String {
        return String.localizedStringWithFormat(NSLocalizedString(string, comment: ""), count)
    }
    
}