//
//  NBFileManager.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 6/19/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

// MARK: - ** Import Modules **

import UIKit

// MARK: - ** Public Enumerations **

// MARK: - NSOverwriteAction Enumeration **

/// File writing actions
public enum NSOverwriteAction : Int {
    /// Indicates to the `NBFileManager` that if a file already exists that is
    /// trying to be saved or moved, to do nothing causing the file action to
    /// fail.
    case none = 0
    /// Indicates to the `NBFileManager` that if a file already exists that is
    /// trying to be saved or moved, to overwrite that file.
    case overwrite
    /// Indicates to the `NBFileManager` that if a file already exists that is
    /// trying to be saved or moved, to use an alternate name instead.
    case useAlternateName
}

/// Convenience data structure that handles `ErrorType`s thrown by
/// `NSFileManager` eliminating the need for `try/catch/finally` blocks.
/// - important: This should _only_ be used in situations where your
/// application handles potential `NSFileManager` errors in an alternate way,
/// such as checking whether, or not, a file exists at a particular path/url,
/// _before_ trying to use any of the static methods provided by this data 
/// structure commit an action on the item at the target path/url.
public struct NBFileManager {
    
    // MARK: -- ** Public Static Properties ** -
    
    /// This closure should (must) be set to propertly handle thrown errors.
    /// The default implementation only prints the error to the console.
    /// - important: Your application should override this, or set this
    /// to `nil` before launching a release.
    public static var errorHandler: ((_ error: Error) -> ())?
    
    // MARK: - ** Private Static Properties ** -
    
    /// The shared default `NSFileManager` instance
    fileprivate static var fileManager = FileManager.default
    
    // MARK: - ** Private Static Methods ** -
    
    fileprivate static func getURL(_ url: URL, forOverwriteAction action: NSOverwriteAction) -> URL? {
        
        let baseURL = url.deletingLastPathComponent()
        let lastPathComponent = url.lastPathComponent
        let ext = lastPathComponent.pathExtension
        
        var url = url
        
        if action == .overwrite && url.exists { do { try fileManager.removeItem(at: url) } catch { errorHandler?(error) } }
        if action == .useAlternateName {
            var i = 1
            while url.exists {
                url = (baseURL +/ (lastPathComponent.stringByDeletingPathExtension + "-\(i)" + (ext.length > 0 ? ".\(ext)" : "")))
                i += 1
            }
        }
        
        return url
    }
    
    fileprivate static func getPath(_ path: String, forOverwriteAction action: NSOverwriteAction) -> String {
        
        let basePath = path.stringByDeletingLastPathComponent
        let lastPathComponent = path.lastPathComponent
        let ext = lastPathComponent.pathExtension
        
        var path = path
        
        if action == .overwrite && fileExistsAtPath(path) { do { try fileManager.removeItem(atPath: path) } catch { errorHandler?(error) } }
        if action == .useAlternateName {
            var i = 1
            while fileExistsAtPath(path) {
                path = (basePath +/ (lastPathComponent.stringByDeletingPathExtension + "-\(i)" + (ext.length > 0 ? ".\(ext)" : "")))
                i += 1
            }
        }
        
        return path
    }
    
}

// MARK: - ** File Exists Methods ** -

extension NBFileManager {
    
    /// Alternate way to check if a file exists at `url`.
    /// - parameter url: The url of the target file.
    /// - returns: `true` if a file exists at `url`; `false` otherwise.
    public static func fileExistsAtURL(_ url: URL) -> Bool {
        return url.exists
    }
    
    /// Checks if a file exists at `path`.
    /// - parameter path: The path of the target file.
    /// - returns: `true` if a file exists at `path`; `false` otherwise.
    public static func fileExistsAtPath(_ path: String) -> Bool {
        return fileManager.fileExists(atPath: path)
    }
    
}

// MARK: - ** Fetch Directory Contents Methods ** -

extension NBFileManager {
    
    /// Performs a shallow search of the specified directory and returns 
    /// URLs for the contained items.
    ///
    /// An array of NSURL objects, each of which identifies a file, directory,
    /// or symbolic link contained in url. If the directory contains no 
    /// entries, this method returns an empty array. If an error occurs, 
    /// this method returns nil and assigns an appropriate error object 
    /// to the error parameter.
    /// - parameter url: The URL for the directory whose contents you want to 
    /// enumerate.
    /// - parameter keys: An array of keys that identify the file properties 
    /// that you want pre-fetched for each item in the directory. For each 
    /// returned URL, the specified properties are fetched and cached in the 
    /// NSURL object. For a list of keys you can specify, see 
    /// [Common File System Resource Keys](documentation/Cocoa/Reference/Foundation/Classes/NSObject_Class/index.html#//apple_ref/occ/cl/NSObject).
    /// - parameter mask: Options for the enumeration. Because this method 
    /// performs only shallow enumerations, options that prevent descending 
    /// into subdirectories or packages are not allowed; the only supported 
    /// option is NSDirectoryEnumerationSkipsHiddenFiles.
    /// - returns: An array of `NSURL` objects, each of which identifies a 
    /// file, directory, or symbolic link contained in url.
    public static func contentsOfDirectoryAtURL(_ url: URL, includingPropertiesForKeys keys: [URLResourceKey]? = nil, options mask: FileManager.DirectoryEnumerationOptions = []) -> [URL] {
        do {
            return try fileManager.contentsOfDirectory(at: url, includingPropertiesForKeys: keys, options: mask)
        } catch { errorHandler?(error) }
        return []
    }
    
    /// Performs a shallow search of the specified directory and returns 
    /// the paths of any contained items.
    ///
    /// An array of NSString objects, each of which identifies a file, 
    /// directory, or symbolic link contained in path. Returns an empty 
    /// array if the directory exists but has no contents. If an error 
    /// occurs, this method returns nil and assigns an appropriate error 
    /// object to the error parameter
    /// - parameter path: The path to the directory whose contents you want 
    /// to enumerate.
    /// - returns: An array of NSString objects, each of which identifies a 
    /// file, directory, or symbolic link contained in path.
    public static func contentsOfDirectoryAtPath(_ path: String) -> [String] {
        do {
            return try fileManager.contentsOfDirectory(atPath: path)
        } catch { errorHandler?(error) }
        return []
    }
    
}

// MARK: - ** Create Directory Methods ** -

extension NBFileManager {
    
    /// Creates a directory with the given attributes at the specified URL.
    ///
    /// `true` if the directory was created, `true` if `createIntermediates` is
    /// set and the directory already exists, or `false` if an error occurred.
    /// - parameter url: A file URL that specifies the directory to create. 
    /// If you want to specify a relative path, you must set the current 
    /// working directory before creating the corresponding `NSURL` object.
    /// This parameter must not be `nil`.
    /// - parameter action: The writing action to take if a file already exists at `url`. Default is `NSOverwriteAction.None`.
    /// - parameter createIntermediates: If true, this method creates any non-existent parent directories as part of creating the directory in url. If false, this method fails if any of the intermediate parent directories does not exist. Default is `true`.
    /// - parameter attributes: The file attributes for the new directory. You can set the owner and group numbers, file permissions, and modification date. If you specify nil for this parameter, the directory is created according to the umask(2) Mac OS X Developer Tools Manual Page of the process. The Constants section lists the global constants used as keys in the attributes dictionary. Some of the keys, such as NSFileHFSCreatorCode and NSFileHFSTypeCode, do not apply to directories. Default is `nil`.
    /// - returns: `true` if the directory was created, `true` if createIntermediates is set and the directory already exists, or `false` if an error occurred.
    public static func createDirectoryAtURL(_ url: URL, forOverwriteAction action: NSOverwriteAction = .none, withIntermediateDirectories createIntermediates: Bool = true, attributes: [String : Any]? = nil) -> URL? {
        guard let url = getURL(url, forOverwriteAction: action) else { return nil }
        do {
            try fileManager.createDirectory(at: url, withIntermediateDirectories: createIntermediates, attributes: attributes)
            return url
        } catch { errorHandler?(error) }
        return nil
    }
    
    /// Creates a directory with given attributes at the specified path.
    ///
    /// `true` if the directory was created, true if `createIntermediates` is set and the directory already exists), or `false` if an error occurred.
    /// - parameter path: A path string identifying the directory to create. You may specify a full path or a path that is relative to the current working directory. This parameter must not be `nil`.
    /// - parameter action: The writing action to take if a file already exists at `path`. Default is `NSOverwriteAction.None`.
    /// - parameter createIntermediates: If `true`, this method creates any non-existent parent directories as part of creating the directory in url. If `false`, this method fails if any of the intermediate parent directories does not exist. Default is `true`.
    /// - parameter attributes: The file attributes for the new directory. You can set the owner and group numbers, file permissions, and modification date. If you specify nil for this parameter, the directory is created according to the umask(2) Mac OS X Developer Tools Manual Page of the process. The Constants section lists the global constants used as keys in the attributes dictionary. Some of the keys, such as NSFileHFSCreatorCode and NSFileHFSTypeCode, do not apply to directories. Default is `nil`.
    /// - returns: `true` if the directory was created, `true` if createIntermediates is set and the directory already exists, or `false` if an error occurred.
    public static func createDirectoryAtPath(_ path: String, forOverwriteAction action: NSOverwriteAction = .none, withIntermediateDirectories createIntermediates: Bool = true, attributes: [String : Any]? = nil) -> String? {
        let path = getPath(path, forOverwriteAction: action)
        do {
            try fileManager.createDirectory(atPath: path, withIntermediateDirectories: createIntermediates, attributes: attributes)
            return path
        } catch { errorHandler?(error) }
        return nil
    }
    
}

// MARK: - ** Create Symbolic Link Methods ** -

extension NBFileManager {
    
    /// Creates a symbolic link at the specified URL that points to an item at the given URL.
    ///
    /// `true` if the symbolic link was created or `false` if an error occurred. This method also returns `false` if a file, directory, or link already exists at url.
    /// - parameter url: The file URL at which to create the new symbolic link. The last path component of the URL issued as the name of the link.
    /// - parameter destURL: The file URL that contains the item to be pointed to by the link. In other words, this is the destination of the link.
    /// - parameter action: The writing action to take if a file already exists at `url`. Default is `NSOverwriteAction.None` which means the file writing action will fail if a file exists at `url`.
    /// - returns: `true` if the symbolic link was created or `false` if an error occurred.
    public static func createSymbolicLinkAtURL(_ url: URL, withDestinationURL destURL: URL?, forOverwriteAction action: NSOverwriteAction = .none) -> URL? {
        guard let destURL = destURL else { return nil }
        guard let url = getURL(url, forOverwriteAction: action) else { return nil }
        do {
            try fileManager.createSymbolicLink(at: url, withDestinationURL: destURL)
            return url
        } catch { errorHandler?(error) }
        return nil
    }
    
    /// Creates a symbolic link that points to the specified destination.
    ///
    /// `true` if the symbolic link was created or `false` if an error occurred. This method also returns `false` if a file, directory, or link already exists at path.
    /// - parameter url: The file URL at which to create the new symbolic link. The last path component of the URL issued as the name of the link.
    /// - parameter destPath: The path that contains the item to be pointed to by the link. In other words, this is the destination of the link.
    /// - parameter action: The writing action to take if a file already exists at `path`. Default is `NSOverwriteAction.None` which means the file writing action will fail if a file exists at `path`.
    /// - returns: `true` if the symbolic link was created or `false` if an error occurred.
    public static func createSymbolicLinkAtPath(_ path: String, withDestinationPath destPath: String?, forOverwriteAction action: NSOverwriteAction = .none) -> String? {
        guard let destPath = destPath else { return nil }
        let path = getPath(path, forOverwriteAction: action)
        do {
            try fileManager.createSymbolicLink(atPath: path, withDestinationPath: destPath)
            return path
        } catch { errorHandler?(error) }
        return nil
    }
    
}

// MARK: - ** Move File Methods **

extension NBFileManager {
    
    /// Moves the file or directory at the specified URL to a new location synchronously.
    ///
    /// `true` if the item was moved successfully or the file manager’s delegate stopped the operation deliberately. Returns `false` if an error occurred.
    /// - parameter srcURL: The file URL that identifies the file or directory you want to move. The URL in this parameter must not be a file reference URL. This parameter must not be `nil`.
    /// - parameter dstURL: The new location for the item in srcURL. The URL in this parameter must not be a file reference URL and must include the name of the file or directory in its new location. This parameter must not be `nil`.
    /// - parameter action: The writing action to take if a file already exists at `url`. Default is `NSOverwriteAction.None`, which means the file writing action will fail if a file exists at `url`.
    /// - returns: `true` if the item was moved successfully or the file manager’s delegate stopped the operation deliberately.
    public static func moveItemAtURL(_ srcURL: URL, toURL dstURL: URL, forOverwriteAction action: NSOverwriteAction = .none) -> URL? {
        guard let dstURL = getURL(dstURL, forOverwriteAction: action) else { return nil }
        do {
            try fileManager.moveItem(at: srcURL, to: dstURL)
            return dstURL
        } catch { errorHandler?(error) }
        return nil
    }
    
    /// Moves the file or directory at the specified path to a new location synchronously.
    ///
    /// `true` if the item was moved successfully or the file manager’s delegate stopped the operation deliberately. Returns `false` if an error occurred.
    /// - parameter srcPath: The path to the file or directory you want to move. This parameter must not be `nil`.
    /// - parameter dstPath: The new path for the item in `srcPath`. This path must include the name of the file or directory in its new location. This parameter must not be `nil`.
    /// - returns: `true` if the item was moved successfully or the file manager’s delegate stopped the operation deliberately.
    public static func moveItemAtPath(_ srcPath: String, toPath dstPath: String, forOverwriteAction action: NSOverwriteAction = .none) -> String? {
        let dstPath = getPath(dstPath, forOverwriteAction: action)
        do {
            try fileManager.moveItem(atPath: srcPath, toPath: dstPath)
            return dstPath
        } catch { errorHandler?(error) }
        return nil
    }
    
}

// MARK: - ** Copy File Methods **

extension NBFileManager {
    
    /// Copies the file at the specified URL to a new location synchronously.
    ///
    /// `true` if the item was copied successfully or the file manager’s delegate stopped the operation deliberately. Returns `false` if an error occurred.
    /// - parameter srcURL: The file URL that identifies the file you want to copy. The URL in this parameter must not be a file reference URL. This parameter must not be nil.
    /// - parameter dstURL: The URL at which to place the copy of srcURL. The URL in this parameter must not be a file reference URL and must include the name of the file in its new location. This parameter must not be nil.
    /// - parameter action: action: The writing action to take if a file already exists at `url`. Default is `NSOverwriteAction.None`, which means the file writing action will fail if a file exists at `url`.
    /// - returns: `true` if the item was copied successfully or the file manager’s delegate stopped the operation deliberately.
    public static func copyItemAtURL(_ srcURL: URL, toURL dstURL: URL, forOverwriteAction action: NSOverwriteAction = .none) -> URL? {
        guard let dstURL = getURL(dstURL, forOverwriteAction: action) else { return nil }
        do {
            try fileManager.copyItem(at: srcURL, to: dstURL)
            return dstURL
        } catch { errorHandler?(error) }
        return nil
    }
    
    /// Copies the file at the specified path to a new location synchronously.
    ///
    /// `true` if the item was copied successfully or the file manager’s delegate stopped the operation deliberately. Returns `false` if an error occurred.
    /// - parameter srcPath: The path to the file or directory you want to move. This parameter must not be `nil`.
    /// - parameter dstPath: The path at which to place the copy of `srcPath`. This path must include the name of the file or directory in its new location. This parameter must not be `nil`.
    /// - parameter action: action: The writing action to take if a file already exists at `path`. Default is `NSOverwriteAction.None`, which means the file writing action will fail if a file exists at `path`.
    /// - returns: `true` if the item was copied successfully or the file manager’s delegate stopped the operation deliberately.
    public static func copyItemAtPath(_ srcPath: String, toPath dstPath: String, forOverwriteAction action: NSOverwriteAction = .none) -> String? {
        let dstPath = getPath(dstPath, forOverwriteAction: action)
        do {
            try fileManager.copyItem(atPath: srcPath, toPath: dstPath)
            return dstPath
        } catch { errorHandler?(error) }
        return nil
    }
    
}

// MARK: - ** Remove File Methods **

extension NBFileManager {
    
    /// Removes the file or directory at the specified URL.
    ///
    /// `true` if the item was removed successfully or if URL was `nil`. Returns `false` if an error occurred. If the delegate stops the operation for a file, this method returns `true`. However, if the delegate stops the operation for a directory, this method returns `false`.
    /// - parameter url: A file URL specifying the file or directory to remove. If the URL specifies a directory, the contents of that directory are recursively removed. You may specify `nil` for this parameter.
    /// - returns: `true` if the item was removed successfully or if URL was `nil`.
    public static func removeItemAtURL(_ url: URL) -> Bool {
        do {
            try fileManager.removeItem(at: url)
            return true
        } catch { errorHandler?(error) }
        return false
    }
    
    /// Removes the file or directory at the specified path.
    ///
    /// `true` if the item was removed successfully or if path was `nil`. Returns `false` if an error occurred. If the delegate stops the operation for a file, this method returns `true`. However, if the delegate stops the operation for a directory, this method returns `false`.
    /// - parameter path: A path string indicating the file or directory to remove. If the path specifies a directory, the contents of that directory are recursively removed. You may specify `nil` for this parameter.
    /// - returns: `true` if the item was removed successfully or if path was `nil`.
    public static func removeItemAtPath(_ path: String) -> Bool {
        do {
            try fileManager.removeItem(atPath: path)
            return true
        } catch { errorHandler?(error) }
        return false
    }
    
}

// MARK: - ** Error Handling **

private var FileManagerDidPresentWarning = false

extension NBFileManager {
    
    /// Default error handler.
    /// - parameter error: The error to handle
    /// - important: Your application should override this, or set this
    /// to `nil` before launching a release.
    public var errorHandler: (_ error: Error) -> () {
        get { return
            { (error: Error) -> () in
                if !FileManagerDidPresentWarning {
                    print("WARNING: Using the default error handler! Your application should override this static property of the NBFileManager class. This warning will only be presented once per session.")
                    FileManagerDidPresentWarning = true
                }
                let error = error as NSError
                NSLog("%@", error.localizedDescription)
            }
        }
        set {}
    }
    
}


