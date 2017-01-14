//
// NSFileManager.swift
// NoodleBox
//
// Created by NoodleOfDeath on 4/17/16.
// Copyright © 2016 NoodleNation. All rights reserved.
//

import Foundation

public let NSFileManagerErrorCodeCopyFailedFileAlreadyExists = 516

/// Convenience `NSFileManager` methods for directory creation
extension FileManager {

    open func createDirectoryAtURL(_ url: URL, withIntermediateDirectories createIntermediates: Bool = true) throws {
        do { 
            try createDirectory(at: url, withIntermediateDirectories: createIntermediates, attributes: nil)
        } catch { throw error }
    }
    
    open func createDirectoryAtPath(_ path: String, withIntermediateDirectories createIntermediates: Bool = true) throws {
        do {
            try createDirectory(atPath: path, withIntermediateDirectories: createIntermediates, attributes: nil)
        } catch { throw error }
    }

}

/// Convenience `NSFileManager` methods for copying files
extension FileManager {
    
    open func copyItemAtURL(_ url: URL, toURL: URL, overwriteExisting: Bool) throws {
        if overwriteExisting { do { try removeItem(at: url) } catch {} }
        do {
            try copyItem(at: url, to: toURL)
        } catch { throw error }
    }
    
    open func copyItemAtPath(_ path: String, toPath: String, overwriteExisting: Bool) throws {
        if overwriteExisting { do { try removeItem(atPath: path) } catch {} }
        do {
            try copyItem(atPath: path, toPath: toPath)
        } catch { throw error }
    }
    
}

/// Convenience `NSFileManager` methods for getting directory contents
extension FileManager {
    
    open func contentsOfDirectoryAtURL(_ url: URL) throws -> [URL] {
        do {
            return try contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [])
        } catch { throw error }
    }
    
}


