// Copyright (c) 2016 NoodleNation <noodlebox@noodlenation.net>
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

public let NBBundleResourcePath: String = NSResourcePath +/ "Bundles"

// MARK: - NBBundle Class

/// Composite class for `NSBundle` that can be overridden and used to
/// represent a group of bundles in a directory with similar extension and
/// functionality
open class NBBundle : NSObject, NSCoding {
    
    // MARK: - Static Properties
    
    /// Encoding/decoding keys
    fileprivate struct CodingKeys {
        /// Key used to encode `name` property.
        static let Name = "Name"
        /// Key used to encode `bundlePath` property.
        static let BundlePath = "BundlePath"
        /// Key used to encode `bundleExtension` property.
        static let BundleExtension = "BundleExtension"
    }
    
    /// Info Dictionary Keys
    fileprivate struct InfoKeys {
        /// Key used to access the `version` property.
        static let Version = "Version"
    }
    
    // MARK: - Get-Only
    
    /// Default bundle name to use
    open class var defaultName: String {
        return "Default"
    }
    
    /// Default directory path for all bundles of this type
    open class var defaultBundlePath: String {
        return NBBundleResourcePath
    }
    
    /// Default extension for all bundles of this type
    open class var defaultBundleExtension: String {
        return "bundle"
    }

    // MARK: -  Internal Properties
    
    // MARK: - Get-Only
    
    /// Name of this bundle without the extension
    open let name: String
    
    /// Embedded `NSBundle` instance
    fileprivate (set) var bundle: Bundle?
    
    /// Bundle dirctory path of this `NBBundle` instance
    fileprivate (set) var bundlePath: String!
    
    /// Bundle extension of this `NBBundle` instance
    fileprivate (set) var bundleExtension: String!
    
    // MARK: - Composite (NSBundle)
    
    /// The bundle info dictionary
    open var info: NSDictionary? { return bundle?.infoDictionary as NSDictionary? }
    
    /// The version of this bundle represented as the modified date
    /// concatenated to the bundle version
    open var version: String {
        return (info?[InfoKeys.Version] as? String ?? "0.0.0") +
            ((bundle?.bundleURL +/ "Contents/Info.plist")?.dateModified.format()
                ?? Date.distantPast.format()) }

    // MARK: - Constructor Methods
    
    public override init() {
        name = type(of: self).defaultName
        bundlePath = type(of: self).defaultBundlePath
        bundleExtension = type(of: self).defaultBundleExtension
        if let path = type(of: self).bundlePathForName(
            name, bundlePath: bundlePath, bundleExtension: bundleExtension) {
            bundle = Bundle(path: path)
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
        bundle = type(of: self).bundleForName(
            name, bundlePath: bundlePath, bundleExtension: bundleExtension)
        self.bundlePath = bundlePath ?? type(of: self).defaultBundlePath
        self.bundleExtension =
            bundleExtension ?? type(of: self).defaultBundleExtension
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        guard
            let name = aDecoder.decodeObject(forKey: CodingKeys.Name) as? String,
            let bundlePath = aDecoder.decodeObject(forKey: CodingKeys.BundlePath) as? String,
            let bundleExtension = aDecoder.decodeObject(forKey: CodingKeys.BundleExtension) as? String else { return nil }
        self.init(name: name, bundlePath: bundlePath, bundleExtension: bundleExtension)
    }

    // MARK: - Deconstructor
    
    deinit {
        
    }
    
    // MARK: - Protocol Methods
    
    // MARK: - NSCoding
    
    open func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: CodingKeys.Name)
        aCoder.encode(bundlePath, forKey: CodingKeys.BundlePath)
        aCoder.encode(bundleExtension, forKey: CodingKeys.BundleExtension)
    }
    
    // MARK: - Internal Methods
    
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
    open static func bundlePathForName(_ name: String, bundlePath: String? = nil, bundleExtension: String? = nil) -> String? {
        return { bundlePath ?? defaultBundlePath }() +/ name +> (bundleExtension ?? defaultBundleExtension)
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
    open static func bundleForName(_ name: String, bundlePath: String? = nil, bundleExtension: String? = nil) -> Bundle? {
        guard let path = bundlePathForName(name, bundlePath: bundlePath ?? defaultBundlePath, bundleExtension: bundleExtension ?? defaultBundleExtension) else { return nil }
        return Bundle(path: path)
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
    open static func versionForBundleNamed(_ name: String, bundlePath: String? = nil, bundleExtension: String? = nil) -> String? {
        return NBBundle(name: name, bundlePath: bundlePath ?? defaultBundlePath, bundleExtension: bundleExtension ?? defaultBundleExtension).version
    }
    
    /// Returns an image resource contained in this wrapped `NSBundle`
    /// - parameter name: The name of the image. For images in asset catalogs,
    /// specify the name of the image asset. For PNG image files, specify the
    /// filename without the filename extension. For all other image file
    /// formats, include the filename extension in the name.
    /// - returns: The image object that best matches the desired traits
    /// with the given `name`, or `nil` if no suitable image was found.
    open func image(named name: String) -> UIImage? {
        return bundle?.image(named: name)
    }

}



