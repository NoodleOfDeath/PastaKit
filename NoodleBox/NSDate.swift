//
//  NSDate.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 6/9/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import UIKit

/// Convenience `NSDate` exetensions
extension NSDate {
    
    /// 
    public convenience init(dateString:String) {
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        let d = dateStringFormatter.dateFromString(dateString)!
        self.init(timeInterval:0, sinceDate:d)
    }
    
    /// Get a formated string using full date style
    /// - returns: A formatted string that represents a date in full date style.
    public func format() -> String {
        return formatWithDateStyle(.FullStyle, timeStyle: .FullStyle)
    }
    
    /// Get a formated string that conforms to a particular date and time style.
    /// - parameter dateStyle: The style for formatting the date.
    /// - parameter timeStyle: The style for formatting the time.
    /// - returns: A formatted string that represents a date.
    public func formatWithDateStyle(dateStyle: NSDateFormatterStyle, timeStyle: NSDateFormatterStyle) -> String {
        let formatter = NSDateFormatter()
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        let dateString = formatter.stringFromDate(self)
        return dateString
    }
    
}
