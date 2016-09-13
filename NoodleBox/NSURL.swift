//
//  NSURL.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 3/4/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import UIKit

/// 
public func += (inout lhs: NSURL?, rhs: Character?) {
    lhs = NSURL(fileURLWithPath:(String(lhs?.path) + String(rhs)))
}

/// 
public func += (inout lhs: NSURL?, rhs: NSURL?) {
    lhs = NSURL(fileURLWithPath:(String(lhs?.path) + String(rhs?.path)))
}

/// 
public func += (inout lhs: NSURL?, rhs: String?) {
    lhs = NSURL(fileURLWithPath:(String(lhs?.path) + String(rhs)))
}

/// 
public func +/ (lhs: NSURL?, rhs: String?) -> NSURL? {
    if let lhs = lhs {
        return lhs.URLByAppendingPathComponent(rhs ?? "")
    } else {
        if let rhs = rhs {
            return NSURL(fileURLWithPath: rhs)
        }
    }
    return nil
}

/// 
public func +/ (lhs: NSURL, rhs: String?) -> NSURL? {
    if let rhs = rhs {
        return lhs.URLByAppendingPathComponent(rhs)
    }
    return nil
}

/// 
public func +/ (lhs: NSURL, rhs: String) -> NSURL {
    return lhs.URLByAppendingPathComponent(rhs)
}

/// 
public func +* (lhs: NSURL?, rhs: String?) -> NSURL? {
    if let lhs = lhs {
        if let rhs = rhs where rhs.length > 0 {
            return lhs.URLByAppendingPathExtension(rhs)
        }
        return lhs
    }
    return nil
}

/// 
public struct NSURLModification: OptionSetType {
    
    public typealias RawValue = Int
    public let rawValue: RawValue
    
    public static let None         = NSURLModification(0)
    public static let Content      = NSURLModification(1 << 0)
    public static let Attribute    = NSURLModification(1 << 1)
    
    public init(rawValue: RawValue)     { self.rawValue = rawValue }
    public init(_ rawValue: RawValue)   { self.init(rawValue: rawValue) }
    
}

// MARK: - ** NSURL Extension **

extension NSURL {
    
    ///  `true` iff a resource exists at `self`.
    public var exists: Bool {
        return checkResourceIsReachableAndReturnError(nil)
    }
    
    /// `true` iff this resource is a local document resource.
    public var local: Bool {
        return path?.containsString(NSDocumentPath) ?? false
    }
    
    /// `true` iff this resource is an iCloud resource. 
    public var ubiquitous: Bool {
        guard let NSUbiquityPath = NSUbiquityPath else { return false }
        return path?.containsString(NSUbiquityPath) ?? false
    }
    
    /// `true` iff this resource is a regular file, or symbolic link to a regular file.
    public var regularFile: Bool {
        return (self[NSURLIsRegularFileKey] as? NSNumber)?.boolValue ?? false
    }
    
    /// `true` iff this resource is a directory, or symbolic link to a directory.
    public var directory: Bool {
        return (self[NSURLIsDirectoryKey] as? NSNumber)?.boolValue ?? false
    }
    
    /// `true` iff this resource is a symbolic link.
    public var symbolicLink: Bool {
        return (self[NSURLIsSymbolicLinkKey] as? NSNumber)?.boolValue ?? false
    }
    
    /// The file size of this resource, iff it is not a directory.
    public var fileSize: UInt64 {
        return (self[NSURLFileSizeKey] as? NSNumber)?.unsignedLongLongValue ?? 0
    }
    
    /// The number of files contained in this resource, iff it is a directory.
    public var fileCount: Int {
        guard directory, let path = self.path,
            let contents = try? 
                NSFileManager.defaultManager().contentsOfDirectoryAtPath(path)
            else { return 0 }
        return contents.count
    }
    
    /// The creation date of this resource, or `distantFuture()`
    /// if unattainable.
    public var dateCreated: NSDate {
        return (self[NSURLCreationDateKey] as? NSDate) ?? .distantFuture()
    }
    
    /// The most recent date this resource was last accessed, or 
    /// `distantFuture()` if unattainable.
    public var dateAccessed: NSDate {
        return self[NSURLContentAccessDateKey] as? NSDate ?? .distantFuture()
    }
    
    /// The most recent date this resource was modified, or 
    /// `distantFuture()` if unattainable.
    public var dateModified: NSDate { return dateModified() }
    
    // MARK: - Methods
    
    /// Get the resource value for `key` of the resource located at `self`.
    public subscript(key: String) -> AnyObject? {
        var resource: AnyObject?
        do {
            try getResourceValue(&resource, forKey: key)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return resource
    }
    
    /// Returns the most recent date this file was modified, or 
    /// `distantFuture()` if unattainable.
    /// - parameter modifications: The modications to check for. 
    /// If `nil` is specified `[.Content, .Attribute]` is used by default.
    /// - returns: The most recent date this file was modified, or 
    /// `distantFuture()` if unattainable.
    public func dateModified(modifications: NSURLModification! = [.Content, .Attribute]) -> NSDate {
        var dates = [NSDate]()
        if modifications.contains(.Content) {
            dates.append((self[NSURLContentModificationDateKey] as? NSDate) ?? .distantFuture())
        }
        if modifications.contains(.Attribute) {
            dates.append((self[NSURLAttributeModificationDateKey] as? NSDate) ?? .distantFuture())
        }
        return dates.sort({ (a: NSDate, b: NSDate) -> Bool in
            return a.timeIntervalSinceNow < b.timeIntervalSinceNow
        }).first ?? .distantFuture()
    }
    
    /// 
    public func localizedCompare(url: NSURL) -> NSComparisonResult {
        guard let name1 = self[NSURLNameKey] as? String, 
            let name2 = url[NSURLNameKey] as? String else { return .OrderedSame }
        return (name1 < name2 ? .OrderedAscending : (name1 > name2 ? .OrderedDescending : .OrderedSame))
    }

}
