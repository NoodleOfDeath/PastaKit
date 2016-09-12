//
//  NSURL.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 3/4/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import UIKit

public func += (inout lhs: NSURL?, rhs: Character?) {
    lhs = NSURL(fileURLWithPath:(String(lhs?.path) + String(rhs)))
}

public func += (inout lhs: NSURL?, rhs: NSURL?) {
    lhs = NSURL(fileURLWithPath:(String(lhs?.path) + String(rhs?.path)))
}

public func += (inout lhs: NSURL?, rhs: String?) {
    lhs = NSURL(fileURLWithPath:(String(lhs?.path) + String(rhs)))
}

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

public func +/ (lhs: NSURL, rhs: String?) -> NSURL? {
    if let rhs = rhs {
        return lhs.URLByAppendingPathComponent(rhs)
    }
    return nil
}

public func +/ (lhs: NSURL, rhs: String) -> NSURL {
    return lhs.URLByAppendingPathComponent(rhs)
}

public func +* (lhs: NSURL?, rhs: String?) -> NSURL? {
    if let lhs = lhs {
        if let rhs = rhs where rhs.length > 0 {
            return lhs.URLByAppendingPathExtension(rhs)
        }
        return lhs
    }
    return nil
}


// MARK: - ** NSURLModification **
public struct NSURLModification: OptionSetType {
    public let rawValue: Int
    public init(rawValue: Int) { self.rawValue = rawValue }
    public static let None         = NSURLModification(rawValue: 0)
    public static let Content      = NSURLModification(rawValue: 1 << 0)
    public static let Attribute    = NSURLModification(rawValue: 1 << 1)
}

// MARK: - ** NSURL Extension **
extension NSURL {

    public func getResourceValue(forKey: String) -> AnyObject? {
        var resource: AnyObject?
        do {
            try getResourceValue(&resource, forKey: forKey)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return resource
    }
    
    public var exists: Bool {
        return checkResourceIsReachableAndReturnError(nil)
    }

    public var local: Bool {
        return path?.containsString(NSDocumentPath) ?? false
    }
    
    public var ubiquitous: Bool {
        guard let NSUbiquityPath = NSUbiquityPath else { return false }
        return path?.containsString(NSUbiquityPath) ?? false
    }

    public var regularFile: Bool {
        return (getResourceValue(NSURLIsRegularFileKey) as? NSNumber)?.boolValue ?? false
    }

    public var directory: Bool {
        return (getResourceValue(NSURLIsDirectoryKey) as? NSNumber)?.boolValue ?? false
    }

    public var symbolicLink: Bool {
        return (getResourceValue(NSURLIsSymbolicLinkKey) as? NSNumber)?.boolValue ?? false
    }

    public var fileSize: UInt64 {
        return (getResourceValue(NSURLFileSizeKey) as? NSNumber)?.unsignedLongLongValue ?? 0
    }

    public var fileCount: Int {
        if directory {
            guard let path = self.path else { return 0 }
            guard let contents = try? NSFileManager.defaultManager().contentsOfDirectoryAtPath(path) else { return 0 }
            return contents.count
        }
        return 0
    }

    public var dateCreated: NSDate {
        return (getResourceValue(NSURLCreationDateKey) as? NSDate) ?? .distantFuture()
    }

    public var dateAccessed: NSDate {
        if let resource = getResourceValue(NSURLContentAccessDateKey) as? NSDate {
            return resource
        }
        return .distantFuture()
    }
    
    public var dateModified: NSDate {
        return dateModified()
    }

    public func dateModified(modifications: NSURLModification! = [.Content, .Attribute]) -> NSDate {
        if modifications.contains(.Content) {
            return (getResourceValue(NSURLContentModificationDateKey) as? NSDate) ?? .distantFuture()
        }
        if modifications.contains(.Attribute) {
            return (getResourceValue(NSURLAttributeModificationDateKey) as? NSDate) ?? .distantFuture()
        }
        return .distantFuture()
    }

    public func localizedCompare(url: NSURL) -> NSComparisonResult {
        var name1, name2: AnyObject?
        do {
            try getResourceValue(&name1, forKey: NSURLNameKey)
            try url.getResourceValue(&name2, forKey: NSURLNameKey)
            if let n1 = name1 as? String {
                if let n2 = name2 as? String {
                    if n1 < n2 {
                        return .OrderedAscending
                    } else if n1 > n2 {
                        return .OrderedDescending
                    }
                    return .OrderedSame
                }
            }
        } catch {
            print(error)
        }
        return .OrderedSame
    }

}
