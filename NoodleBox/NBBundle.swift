//
//  NBBundle.swift
//  ByteMe
//
//  Created by Thom Morgan on 5/22/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

// MARK: - ** Import Modules **

import UIKit

public let NBBundleResourcePath: String = NSResourcePath +/ "Bundles"

// MARK: - ** NBBundle Class **

/// Composite class for `NSBundle` that can be overridden and used to
/// represent a group of bundles in a directory with similar extension and
/// functionality
public class NBBundle : NSObject, NSCoding {
    
    // MARK: - ** Static Properties **
    
    /// Encoding/decoding keys
    private struct CodingKeys {
        /// Key used to encode `name` property.
        static let Name = "Name"
        /// Key used to encode `bundlePath` property.
        static let BundlePath = "BundlePath"
        /// Key used to encode `bundleExtension` property.
        static let BundleExtension = "BundleExtension"
    }
    
    /// Info Dictionary Keys
    private struct InfoKeys {
        /// Key used to access the `version` property.
        static let Version = "Version"
    }
    
    // MARK: - Get-Only
    
    /// Default bundle name to use
    public class var defaultName: String {
        return "Default"
    }
    
    /// Default directory path for all bundles of this type
    public class var defaultBundlePath: String {
        return NBBundleResourcePath
    }
    
    /// Default extension for all bundles of this type
    public class var defaultBundleExtension: String {
        return "bundle"
    }

    // MARK: - **  Internal Properties **
    
    // MARK: - Get-Only
    
    /// Name of this bundle without the extension
    public let name: String
    
    /// Embedded `NSBundle` instance
    private (set) var bundle: NSBundle?
    
    /// Bundle dirctory path of this `NBBundle` instance
    private (set) var bundlePath: String!
    
    /// Bundle extension of this `NBBundle` instance
    private (set) var bundleExtension: String!
    
    // MARK: - Composite (NSBundle)
    
    /// The bundle info dictionary
    public var info: NSDictionary? { return bundle?.infoDictionary }
    
    /// The version of this bundle represented as the modified date
    /// concatenated to the bundle version
    public var version: String {
        return (info?[InfoKeys.Version] as? String ?? "0.0.0") +
            ((bundle?.bundleURL +/ "Contents/Info.plist")?.dateModified.format()
                ?? NSDate.distantPast().format()) }

    // MARK: - ** Constructor Methods **
    
    public override init() {
        name = self.dynamicType.defaultName
        bundlePath = self.dynamicType.defaultBundlePath
        bundleExtension = self.dynamicType.defaultBundleExtension
        if let path = self.dynamicType.bundlePathForName(
            name, bundlePath: bundlePath, bundleExtension: bundleExtension) {
            bundle = NSBundle(path: path)
        }
        super.init()
    }
    
    /// Creates an `NSBundle` wrapper instance located at `bundlePath`
    /// and named `name + "." + bundleExtension`.
    /// - returns: An `NSBundle` wrapper instance located at `bundlePath`
    /// and named `name + "." + bundleExtension`.
    public required init(name: String, bundlePath: String? = nil,
                  bundleExtension: String? = nil) {
        self.name = name
        super.init()
        bundle = self.dynamicType.bundleForName(
            name, bundlePath: bundlePath, bundleExtension: bundleExtension)
        self.bundlePath = bundlePath ?? self.dynamicType.defaultBundlePath
        self.bundleExtension =
            bundleExtension ?? self.dynamicType.defaultBundleExtension
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        guard
            let name = aDecoder.decodeObjectForKey(CodingKeys.Name) as? String,
            let bundlePath = aDecoder.decodeObjectForKey(CodingKeys.BundlePath) as? String,
            let bundleExtension = aDecoder.decodeObjectForKey(CodingKeys.BundleExtension) as? String else { return nil }
        self.init(name: name, bundlePath: bundlePath, bundleExtension: bundleExtension)
    }

    // MARK: - ** Deconstructor **
    
    deinit {
        
    }
    
    // MARK: - ** Protocol Methods **
    
    // MARK: - NSCoding
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: CodingKeys.Name)
        aCoder.encodeObject(bundlePath, forKey: CodingKeys.BundlePath)
        aCoder.encodeObject(bundleExtension, forKey: CodingKeys.BundleExtension)
    }
    
    // MARK: - ** Internal Methods **
    
    /// Constructs the absolute bundle path of a bundle in the directory
    /// `bundlePath` named `name` and with the extension `bundleExtension`.
    /// - parameter name: The name of the bundle without the extension
    /// - parameter bundlePath: The absolute directory path containing the
    /// bundle. If set to `nil` the static `defaultBundlePath` value will
    /// be used instead.
    /// - parameter bundleExtension: The extension of the target bundle. If
    /// set to `nil` the the static `defaultBundleExtension` value will be
    /// used instead
    /// - returns: The full bundle path of the bundle named `name`.
    /// - note: This method only builds a path string, it does not imply
    /// anything about the existence of bundle in the filesystem or its
    /// configuration.
    public static func bundlePathForName(name: String, bundlePath: String? = nil, bundleExtension: String? = nil) -> String? {
        return { bundlePath ?? defaultBundlePath }() +/ name +* (bundleExtension ?? defaultBundleExtension)
    }
    
    /// Returns the `NSBundle` object located in the directory `bundlePath`
    /// named `name` and with the extension `bundleExtension`, or `nil`
    /// if no such item exists in the filesystem.
    /// - parameter name: The name of the bundle without the extension
    /// - parameter bundlePath: The absolute directory path containing the
    /// bundle. If set to `nil` the static `defaultBundlePath` value will
    /// be used instead.
    /// - parameter bundleExtension: The extension of the target bundle. If
    /// set to `nil` the the static `defaultBundleExtension` value will be
    /// used instead
    /// - returns: The `NSBundle` object located in the directory `bundlePath`
    /// named `name` and with the extension `bundleExtension`, or `nil`
    /// if no such item exists in the filesystem.
    public static func bundleForName(name: String, bundlePath: String? = nil, bundleExtension: String? = nil) -> NSBundle? {
        guard let path = bundlePathForName(name, bundlePath: bundlePath ?? defaultBundlePath, bundleExtension: bundleExtension ?? defaultBundleExtension) else { return nil }
        return NSBundle(path: path)
    }
    
    /// Returns the version of a bundle at the given `bundlePath` named
    /// `name` with extension `bundleExtension`
    /// - parameter name: The name of the bundle without the extension
    /// - parameter bundlePath: The absolute directory path containing the
    /// bundle. If set to `nil` the static `defaultBundlePath` value will
    /// be used instead.
    /// - parameter bundleExtension: The extension of the target bundle. If
    /// set to `nil` the the static `defaultBundleExtension` value will be
    /// used instead
    /// - returns: The version of the bundle as a string
    public static func versionForBundleNamed(name: String, bundlePath: String? = nil, bundleExtension: String? = nil) -> String? {
        return NBBundle(name: name, bundlePath: bundlePath ?? defaultBundlePath, bundleExtension: bundleExtension ?? defaultBundleExtension).version
    }
    
    /// Returns an image resource contained in this wrapped `NSBundle`
    /// - parameter name: The name of the image. For images in asset catalogs,
    /// specify the name of the image asset. For PNG image files, specify the
    /// filename without the filename extension. For all other image file
    /// formats, include the filename extension in the name.
    /// - returns: The image object that best matches the desired traits
    /// with the given `name`, or `nil` if no suitable image was found.
    public func imageNamed(name: String) -> UIImage? {
        return bundle?.imageNamed(name)
    }

}



