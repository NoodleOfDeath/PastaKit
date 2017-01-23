//
//  NSDate.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 6/9/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import UIKit

/// Convenience `NSDate` exetensions
extension Date {
    
    /// 
    public init(dateString:String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        dateStringFormatter.locale = Locale(identifier: "en_US_POSIX")
        let d = dateStringFormatter.date(from: dateString)!
        self.init(timeInterval: 0, since: d)
    }
    
    /// Get a formated string using full date style
    /// - returns: A formatted string that represents a date in full date style.
    public func format() -> String {
        return formatWithDateStyle(.full, timeStyle: .full)
    }
    
    /// Get a formated string that conforms to a particular date and time style.
    /// - parameter dateStyle: The style for formatting the date.
    /// - parameter timeStyle: The style for formatting the time.
    /// - returns: A formatted string that represents a date.
    public func formatWithDateStyle(_ dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        let dateString = formatter.string(from: self)
        return dateString
    }
    
}
