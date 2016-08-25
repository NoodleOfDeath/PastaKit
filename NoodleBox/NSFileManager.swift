//
//  NSFileManager.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 4/17/16.
//  Copyright © 2016 NoodleOfDeath. All rights reserved.
//

import Foundation

public let NSFileManagerErrorCodeCopyFailedFileAlreadyExists = 516

/// Convenience `NSFileManager` methods for directory creation
extension NSFileManager {

    public func createDirectoryAtURL(url: NSURL, withIntermediateDirectories createIntermediates: Bool = true) throws {
        do { 
            try createDirectoryAtURL(url, withIntermediateDirectories: createIntermediates, attributes: nil)
        } catch { throw error }
    }
    
    public func createDirectoryAtPath(path: String, withIntermediateDirectories createIntermediates: Bool = true) throws {
        do {
            try createDirectoryAtPath(path, withIntermediateDirectories: createIntermediates, attributes: nil)
        } catch { throw error }
    }

}

/// Convenience `NSFileManager` methods for copying files
extension NSFileManager {
    
    public func copyItemAtURL(url: NSURL, toURL: NSURL, overwriteExisting: Bool) throws {
        if overwriteExisting { do { try removeItemAtURL(url) } catch {} }
        do {
            try copyItemAtURL(url, toURL: toURL)
        } catch { throw error }
    }
    
    public func copyItemAtPath(path: String, toPath: String, overwriteExisting: Bool) throws {
        if overwriteExisting { do { try removeItemAtPath(path) } catch {} }
        do {
            try copyItemAtPath(path, toPath: toPath)
        } catch { throw error }
    }
    
}

/// Convenience `NSFileManager` methods for getting directory contents
extension NSFileManager {
    
    public func contentsOfDirectoryAtURL(url: NSURL) throws -> [NSURL] {
        do {
            return try contentsOfDirectoryAtURL(url, includingPropertiesForKeys: nil, options: [])
        } catch { throw error }
    }
    
}


