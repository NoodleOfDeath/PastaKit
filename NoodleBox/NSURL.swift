//
//  NSURL.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 3/4/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import UIKit

/// 
public func += (lhs: inout URL?, rhs: Character?) {
    lhs = URL(fileURLWithPath:(String(describing: lhs?.path) + String(describing: rhs)))
}

/// 
public func += (lhs: inout URL?, rhs: URL?) {
    lhs = URL(fileURLWithPath:(String(describing: lhs?.path) + String(describing: rhs?.path)))
}

/// 
public func += (lhs: inout URL?, rhs: String?) {
    lhs = URL(fileURLWithPath:(String(describing: lhs?.path) + String(describing: rhs)))
}

/// 
public func +/ (lhs: URL?, rhs: String?) -> URL? {
    if let lhs = lhs {
        return lhs.appendingPathComponent(rhs ?? "")
    } else {
        if let rhs = rhs {
            return URL(fileURLWithPath: rhs)
        }
    }
    return nil
}

/// 
public func +/ (lhs: URL, rhs: String?) -> URL? {
    if let rhs = rhs {
        return lhs.appendingPathComponent(rhs)
    }
    return nil
}

/// 
public func +/ (lhs: URL, rhs: String) -> URL {
    return lhs.appendingPathComponent(rhs)
}

/// 
public func +* (lhs: URL?, rhs: String?) -> URL? {
    if let lhs = lhs {
        if let rhs = rhs , rhs.length > 0 {
            return lhs.appendingPathExtension(rhs)
        }
        return lhs
    }
    return nil
}

/// 
public struct NSURLModification: OptionSet {
    
    public typealias RawValue = Int
    public let rawValue: RawValue
    
    public static let None         = NSURLModification(0)
    public static let Content      = NSURLModification(1 << 0)
    public static let Attribute    = NSURLModification(1 << 1)
    
    public init(rawValue: RawValue)     { self.rawValue = rawValue }
    public init(_ rawValue: RawValue)   { self.init(rawValue: rawValue) }
    
}

// MARK: - ** NSURL Extension **

extension URL {
    
    ///  `true` iff a resource exists at `self`.
    public var exists: Bool {
        return checkResourceIsReachableAndReturnError(nil)
    }
    
    /// `true` iff this resource is a local document resource.
    public var local: Bool {
        return path.contains(NSDocumentPath) ?? false
    }
    
    /// `true` iff this resource is an iCloud resource. 
    public var ubiquitous: Bool {
        guard let NSUbiquityPath = NSUbiquityPath else { return false }
        return path.contains(NSUbiquityPath) ?? false
    }
    
    /// `true` iff this resource is a regular file, or symbolic link to a regular file.
    public var regularFile: Bool {
        return (self[URLResourceKey.isRegularFileKey.rawValue] as? NSNumber)?.boolValue ?? false
    }
    
    /// `true` iff this resource is a directory, or symbolic link to a directory.
    public var directory: Bool {
        return (self[URLResourceKey.isDirectoryKey.rawValue] as? NSNumber)?.boolValue ?? false
    }
    
    /// `true` iff this resource is a symbolic link.
    public var symbolicLink: Bool {
        return (self[URLResourceKey.isSymbolicLinkKey.rawValue] as? NSNumber)?.boolValue ?? false
    }
    
    /// The file size of this resource, iff it is not a directory.
    public var fileSize: UInt64 {
        return (self[URLResourceKey.fileSizeKey.rawValue] as? NSNumber)?.uint64Value ?? 0
    }
    
    /// The number of files contained in this resource, iff it is a directory.
    public var fileCount: Int {
        guard directory, let path = self.path,
            let contents = try? 
                FileManager.default.contentsOfDirectory(atPath: path)
            else { return 0 }
        return contents.count
    }
    
    /// The creation date of this resource, or `distantFuture()`
    /// if unattainable.
    public var dateCreated: Date {
        return (self[URLResourceKey.creationDateKey.rawValue] as? Date) ?? .distantFuture
    }
    
    /// The most recent date this resource was last accessed, or 
    /// `distantFuture()` if unattainable.
    public var dateAccessed: Date {
        return self[URLResourceKey.contentAccessDateKey.rawValue] as? Date ?? .distantFuture
    }
    
    /// The most recent date this resource was modified, or 
    /// `distantFuture()` if unattainable.
    public var dateModified: Date { return dateModified() }
    
    // MARK: - Methods
    
    /// Get the resource value for `key` of the resource located at `self`.
    public subscript(key: String) -> AnyObject? {
        var resource: AnyObject?
        do {
            try getResourceValue(&resource, forKey: URLResourceKey(rawValue: key))
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
    public func dateModified(_ modifications: NSURLModification! = [.Content, .Attribute]) -> Date {
        var dates = [Date]()
        if modifications.contains(.Content) {
            dates.append((self[URLResourceKey.contentModificationDateKey.rawValue] as? Date) ?? .distantFuture)
        }
        if modifications.contains(.Attribute) {
            dates.append((self[URLResourceKey.attributeModificationDateKey.rawValue] as? Date) ?? .distantFuture)
        }
        return dates.sorted(by: { (a: Date, b: Date) -> Bool in
            return a.timeIntervalSinceNow < b.timeIntervalSinceNow
        }).first ?? .distantFuture
    }
    
    /// 
    public func localizedCompare(_ url: URL) -> ComparisonResult {
        guard let name1 = self[URLResourceKey.nameKey.rawValue] as? String, 
            let name2 = url[URLResourceKey.nameKey.rawValue] as? String else { return .orderedSame }
        return (name1 < name2 ? .orderedAscending : (name1 > name2 ? .orderedDescending : .orderedSame))
    }

}
