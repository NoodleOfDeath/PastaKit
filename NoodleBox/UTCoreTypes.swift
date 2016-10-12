//
//  UTCoreTypes.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 6/20/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

// MARK: - ** Import Modules **

import MobileCoreServices

// MARK: - ** Public Constants **

public let kUTTypeUnknown = "open.unknown"

// MARK: - ** Public Operations ** -

public func == (lhs: UTType, rhs: UTType) -> Bool {
    return lhs.rawValue == rhs.rawValue
}

public func != (lhs: UTType, rhs: UTType) -> Bool {
    return lhs.rawValue != rhs.rawValue
}

// MARK: - ** Protocols **

/// A simple protocol in which an object has a `uttype`.
public protocol UTTypeProtocol {
    var uttype: UTType { get }
}

// MARK: - ** UTType Structure ** -

/// A bridging structure that converts all `"kUTType.*"` constants and
/// modularizes them into a `UTType` static constant.
///
/// **Example:** `kUTTypeBMP` is modularized to `UTType.BMP`.
public struct UTType : CFRawRepresentable, Equatable {
    
    // MARK: - ** Type Aliases **
    
    public typealias RawValue = String
    public typealias CoreValue = CFString
    
    // MARK: - ** Public Variables **
    
    // MARK: - Get-Only
    
    public let rawValue: RawValue
    public var coreValue: CoreValue { return rawValue as UTType.CoreValue }
    
    // MARK: - ** Static Properties **
    
    // MARK: - Get-Only
    
    public static let DefaultRawValue: RawValue = kUTTypeUnknown as String
    public static let DefaultCoreValue: CoreValue = kUTTypeUnknown as UTType.CoreValue
    
    /// Unknown UTType indicates an encounter with raw/core values that
    /// do not point to a known UTType.
    public static let Unknown = UTType(kUTTypeUnknown)
    
    /*
     File:       UTCoreTypes.h
     
     Contains:   String constants for core uniform type identifiers
     
     Copyright:  (c) 2004-2012 by Apple Inc. All rights reserved.
     
     Bugs?:      For bug reports, consult the following page on
     the World Wide Web:
     
     http://developer.apple.com/bugreporter/
     
     */
    
    /*
     *  kUTTypeItem
     *
     *    generic base type for most things
     *    (files, directories)
     *
     *    UTI: open.item
     *
     *
     *  kUTTypeContent
     *
     *    base type for anything containing user-viewable document content
     *    (documents, pasteboard data, and document packages)
     *
     *    UTI: open.content
     *
     *
     *  kUTTypeCompositeContent
     *
     *    base type for content formats supporting mixed embedded content
     *    (i.e., compound documents)
     *
     *    UTI: open.composite-content
     *    conform///  to: open.content
     *
     *
     *  kUTTypeMessage
     *
     *    base type for messages (email, IM, etc.)
     *
     *    UTI: open.message
     *
     *
     *  kUTTypeContact
     *
     *    contact information, e.g. for a person, group, organization
     *
     *    UTI: open.contact
     *
     *
     *  kUTTypeArchive
     *
     *    an archive of files and directories
     *
     *    UTI: open.archive
     *
     *
     *  kUTTypeDiskImage
     *
     *    a data item mountable as a volume
     *
     *    UTI: open.disk-image
     *
     */
    @available(iOS 3.0, *)
    public static let Item = UTType(kUTTypeItem)
    @available(iOS 3.0, *)
    public static let Content = UTType(kUTTypeContent)
    @available(iOS 3.0, *)
    public static let CompositeContent = UTType(kUTTypeCompositeContent)
    @available(iOS 3.0, *)
    public static let Message = UTType(kUTTypeMessage)
    @available(iOS 3.0, *)
    public static let Contact = UTType(kUTTypeContact)
    @available(iOS 3.0, *)
    public static let Archive = UTType(kUTTypeArchive)
    @available(iOS 3.0, *)
    public static let DiskImage = UTType(kUTTypeDiskImage)
    
    /*
     *  kUTTypeData
     *
     *    base type for any sort of simple byte stream,
     *    including files and in-memory data
     *
     *    UTI: open.data
     *    conform///  to: open.item
     *
     *
     *  kUTTypeDirectory
     *
     *    file system directory 
     *    (includes packages AND folders)
     *
     *    UTI: open.directory
     *    conform///  to: open.item
     *
     *
     *  kUTTypeResolvable
     *
     *    symlink and alias file types conform to this UTI
     *
     *    UTI: com.apple.resolvable
     *
     *
     *  kUTTypeSymLink
     *
     *    a symbolic link
     *
     *    UTI: open.symlink
     *    conform///  to: open.item, com.apple.resolvable
     *
     *
     *  kUTTypeExecutable
     *
     *    an executable item
     *    UTI: open.executable
     *    conform///  to: open.item
     *
     *
     *  kUTTypeMountPoint
     *
     *    a volume mount point (resolvable, resolves to the root dir of a volume)
     *
     *    UTI: com.apple.mount-point
     *    conform///  to: open.item, com.apple.resolvable
     *
     *
     *  kUTTypeAliasFile
     *
     *    a fully-formed alias file
     *
     *    UTI: com.apple.alias-file
     *    conform///  to: open.data, com.apple.resolvable
     *
     *
     *  kUTTypeAliasRecord
     *
     *    raw alias data
     *
     *    UTI: com.apple.alias-record
     *    conform///  to: open.data, com.apple.resolvable
     *
     *
     *  kUTTypeURLBookmarkData
     *
     *    URL bookmark
     *
     *    UTI: com.apple.bookmark
     *    conform///  to: open.data, com.apple.resolvable
     *
     */
    @available(iOS 3.0, *)
    public static let Data = UTType(kUTTypeData)
    @available(iOS 3.0, *)
    public static let Directory = UTType(kUTTypeDirectory)
    @available(iOS 3.0, *)
    public static let Resolvable = UTType(kUTTypeResolvable)
    @available(iOS 3.0, *)
    public static let SymLink = UTType(kUTTypeSymLink)
    @available(iOS 8.0, *)
    public static let Executable = UTType(kUTTypeExecutable)
    @available(iOS 3.0, *)
    public static let MountPoint = UTType(kUTTypeMountPoint)
    @available(iOS 3.0, *)
    public static let AliasFile = UTType(kUTTypeAliasFile)
    @available(iOS 3.0, *)
    public static let AliasRecord = UTType(kUTTypeAliasRecord)
    @available(iOS 8.0, *)
    public static let URLBookmarkData = UTType(kUTTypeURLBookmarkData)
    
    /*
     *  kUTTypeURL
     *
     *    The bytes of a URL
     *    (OSType 'url ')
     *
     *    UTI: open.url
     *    conform///  to: open.data
     *
     *
     *  kUTTypeFileURL
     *
     *    The text of a "file:" URL 
     *    (OSType 'furl')
     *
     *    UTI: open.file-url
     *    conform///  to: open.url
     *
     */
    @available(iOS 3.0, *)
    public static let URL = UTType(kUTTypeURL)
    @available(iOS 3.0, *)
    public static let FileURL = UTType(kUTTypeFileURL)
    
    /*
     *  kUTTypeText
     *
     *    base type for all text-encoded data, 
     *    including text with markup (HTML, RTF, etc.)
     *
     *    UTI: open.text
     *    conform///  to: open.data, open.content
     *
     *
     *  kUTTypePlainText
     *
     *    text with no markup, unspecified encoding
     *
     *    UTI: open.plain-text
     *    conform///  to: open.text
     *
     *
     *  kUTTypeUTF8PlainText
     *
     *    plain text, UTF-8 encoding
     *    (OSType 'utf8', NSPasteboardType "NSStringPBoardType")
     *
     *    UTI: open.utf8-plain-text
     *    conform///  to: open.plain-text
     *
     *
     *  kUTTypeUTF16ExternalPlainText
     *
     *    plain text, UTF-16 encoding, with BOM, or if BOM 
     *    is not present, has "external representation" 
     *    byte order (big-endian).
     *    (OSType 'ut16')
     *
     *    UTI: open.utf16-external-plain-text
     *    conform///  to: open.plain-text
     *
     *
     *  kUTTypeUTF16PlainText
     *
     *    plain text, UTF-16 encoding, native byte order, optional BOM
     *    (OSType 'utxt')
     *
     *    UTI: open.utf16-plain-text
     *    conform///  to: open.plain-text
     *
     *
     *  kUTTypeDelimitedText
     *
     *    text containing delimited values
     *
     *    UTI: open.delimited-values-text
     *    conform///  to: open.text
     *
     *
     *  kUTTypeCommaSeparatedText
     *
     *    text containing comma-separated values (.csv)
     *
     *    UTI: open.comma-separated-values-text
     *    conform///  to: open.delimited-values-text
     *
     *
     *  kUTTypeTabSeparatedText
     *
     *    text containing tab-separated values
     *
     *    UTI: open.tab-separated-values-text
     *    conform///  to: open.delimited-values-text
     *
     *
     *  kUTTypeUTF8TabSeparatedText
     *
     *    UTF-8 encoded text containing tab-separated values
     *
     *    UTI: open.utf8-tab-separated-values-text
     *    conform///  to: open.tab-/// eparated-values-text, open.utf8-plain-text
     *
     *
     *  kUTTypeRTF
     *
     *    Rich Text EFat
     *
     *    UTI: open.rtf
     *    conform///  to: open.text
     *
     */
    @available(iOS 3.0, *)
    public static let Text = UTType(kUTTypeText)
    @available(iOS 3.0, *)
    public static let PlainText = UTType(kUTTypePlainText)
    @available(iOS 3.0, *)
    public static let UTF8PlainText = UTType(kUTTypeUTF8PlainText)
    @available(iOS 3.0, *)
    public static let UTF16ExternalPlainText = UTType(kUTTypeUTF16ExternalPlainText)
    @available(iOS 3.0, *)
    public static let UTF16PlainText = UTType(kUTTypeUTF16PlainText)
    @available(iOS 8.0, *)
    public static let DelimitedText = UTType(kUTTypeDelimitedText)
    @available(iOS 8.0, *)
    public static let CommaSeparatedText = UTType(kUTTypeCommaSeparatedText)
    @available(iOS 8.0, *)
    public static let TabSeparatedText = UTType(kUTTypeTabSeparatedText)
    @available(iOS 8.0, *)
    public static let UTF8TabSeparatedText = UTType(kUTTypeUTF8TabSeparatedText)
    @available(iOS 3.0, *)
    public static let RTF = UTType(kUTTypeRTF)
    
    /*
     *  kUTTypeHTML
     *
     *    HTML, any version
     *
     *    UTI: open.html
     *    conform///  to: open.text
     *
     *
     *  kUTTypeXML
     *
     *    generic XML
     *
     *    UTI: open.xml
     *    conform///  to: open.text
     *
     */
    @available(iOS 3.0, *)
    public static let HTML = UTType(kUTTypeHTML)
    @available(iOS 3.0, *)
    public static let XML = UTType(kUTTypeXML)
    
    /*
     *  kUTTypeSourceCode
     *
     *    abstract type for source code (any language)
     *
     *    UTI: open.source-code
     *    conform///  to: open.plain-text
     *
     *
     *  kUTTypeAssemblyLanguageSource
     *
     *    assembly language source (.s)
     *
     *    UTI: open.assembly-source
     *    conform///  to: open.source-code
     *
     *
     *  kUTTypeCSource
     *
     *    C source code (.c)
     *
     *    UTI: open.c-source
     *    conform///  to: open.source-code
     *
     *
     *  kUTTypeObjectiveCSource
     *
     *    Objective-C source code (.m)
     *
     *    UTI: open.objective-c-source
     *    conform///  to: open.source-code
     *
     *
     *  kUTTypeSwiftSource
     *
     *    Swift source code (.swift)
     *
     *    UTI: open.swift-source
     *    conform///  to: open.source-code
     *
     *
     *  kUTTypeCPlusPlusSource
     *
     *    C++ source code (.cp, etc.)
     *
     *    UTI: open.c-plus-plus-source
     *    conform///  to: open.source-code
     *
     *
     *  kUTTypeObjectiveCPlusPlusSource
     *
     *    Objective-C++ source code
     *
     *    UTI: open.objective-c-plus-plus-source
     *    conform///  to: open.source-code
     *
     *
     *  kUTTypeCHeader
     *
     *    C header
     *
     *    UTI: open.c-header
     *    conform///  to: open.source-code
     *
     *
     *  kUTTypeCPlusPlusHeader
     *
     *    C++ header
     *
     *    UTI: open.c-plus-plus-header
     *    conform///  to: open.source-code
     *
     *
     *  kUTTypeJavaSource
     *
     *    Java source code
     *
     *    UTI: com.sun.java-source
     *    conform///  to: open.source-code
     *
     */
    @available(iOS 3.0, *)
    public static let SourceCode = UTType(kUTTypeSourceCode)
    @available(iOS 8.0, *)
    public static let AssemblyLanguageSource = UTType(kUTTypeAssemblyLanguageSource)
    @available(iOS 3.0, *)
    public static let CSource = UTType(kUTTypeCSource)
    @available(iOS 3.0, *)
    public static let ObjectiveCSource = UTType(kUTTypeObjectiveCSource)
    @available(iOS 9.0, *)
    public static let SwiftSource = UTType(kUTTypeSwiftSource)
    @available(iOS 3.0, *)
    public static let CPlusPlusSource = UTType(kUTTypeCPlusPlusSource)
    @available(iOS 3.0, *)
    public static let ObjectiveCPlusPlusSource = UTType(kUTTypeObjectiveCPlusPlusSource)
    @available(iOS 3.0, *)
    public static let CHeader = UTType(kUTTypeCHeader)
    @available(iOS 3.0, *)
    public static let CPlusPlusHeader = UTType(kUTTypeCPlusPlusHeader)
    @available(iOS 3.0, *)
    public static let JavaSource = UTType(kUTTypeJavaSource)
    
    /*
     *  kUTTypeScript
     *
     *    scripting language source
     *
     *    UTI: open.script
     *    conform///  to: open.source-code
     *
     *
     *  kUTTypeAppleScript
     *
     *    AppleScript text format (.applescript)
     *
     *    UTI: com.apple.applescript.text
     *    conform///  to: open.script
     *
     *
     *  kUTTypeOSAScript
     *
     *    public Scripting Architecture script binary format (.scpt)
     *
     *    UTI: com.apple.applescript.script
     *    conform///  to: open.data, open.script
     *
     *
     *  kUTTypeOSAScriptBundle
     *
     *    public Scripting Architecture script bundle format (.scptd)
     *
     *    UTI: com.apple.applescript.script-bundle
     *    conform///  to: com.apple.bundle, com.apple.package, open.script
     *
     *
     *  kUTTypeJavaScript
     *
     *    JavaScript source code
     *
     *    UTI: com.netscape.javascript-source
     *    conform///  to: open./// ource-code, open.executable
     *
     *
     *  kUTTypeShellScript
     *
     *    base type for shell scripts
     *
     *    UTI: open.shell-script
     *    conform///  to: open.script
     *
     *
     *  kUTTypePerlScript
     *
     *    Perl script
     *
     *    UTI: open.perl-script
     *    conform///  to: open.shell-script
     *
     *
     *  kUTTypePythonScript
     *
     *    Python script
     *
     *    UTI: open.python-script
     *    conform///  to: open.shell-script
     *
     *
     *  kUTTypeRubyScript
     *
     *    Ruby script
     *
     *    UTI: open.ruby-script
     *    conform///  to: open.shell-script
     *
     *
     *  kUTTypePHPScript
     *
     *    PHP script
     *
     *    UTI: open.php-script
     *    conform///  to: open.shell-script
     *
     */
    @available(iOS 8.0, *)
    public static let Script = UTType(kUTTypeScript)
    @available(iOS 8.0, *)
    public static let AppleScript = UTType(kUTTypeAppleScript)
    @available(iOS 8.0, *)
    public static let OSAScript = UTType(kUTTypeOSAScript)
    @available(iOS 8.0, *)
    public static let OSAScriptBundle = UTType(kUTTypeOSAScriptBundle)
    @available(iOS 8.0, *)
    public static let JavaScript = UTType(kUTTypeJavaScript)
    @available(iOS 8.0, *)
    public static let ShellScript = UTType(kUTTypeShellScript)
    @available(iOS 8.0, *)
    public static let PerlScript = UTType(kUTTypePerlScript)
    @available(iOS 8.0, *)
    public static let PythonScript = UTType(kUTTypePythonScript)
    @available(iOS 8.0, *)
    public static let RubyScript = UTType(kUTTypeRubyScript)
    @available(iOS 8.0, *)
    public static let PHPScript = UTType(kUTTypePHPScript)
    
    /*
     *  kUTTypeJSON
     *
     *    JavaScript object notation (JSON) data
     *    NOTE: JSON almost but doesn't quite conform to
     *    com.netscape.javascript-source
     *
     *    UTI: open.json
     *    conform///  to: open.text
     *
     *
     *  kUTTypePropertyList
     *
     *    base type for property lists
     *
     *    UTI: com.apple.property-list
     *    conform///  to: open.data
     *
     *
     *  kUTTypeXMLPropertyList
     *
     *    XML property list
     *
     *    UTI: com.apple.xml-property-list
     *    conform///  to: open.xml, com.apple.property-list
     *
     *
     *  kUTTypeBinaryPropertyList
     *
     *    XML property list
     *
     *    UTI: com.apple.binary-property-list
     *    conforms to: com.apple.property-list
     *
     */
    @available(iOS 8.0, *)
    public static let JSON = UTType(kUTTypeJSON)
    @available(iOS 8.0, *)
    public static let PropertyList = UTType(kUTTypePropertyList)
    @available(iOS 8.0, *)
    public static let XMLPropertyList = UTType(kUTTypeXMLPropertyList)
    @available(iOS 8.0, *)
    public static let BinaryPropertyList = UTType(kUTTypeBinaryPropertyList)
    
    /*
     *  kUTTypePDF
     *
     *    Adobe PDF
     *
     *    UTI: com.adobe.pdf
     *    conform///  to: open.data, open.composite-content
     *
     *
     *  kUTTypeRTFD
     *
     *    Rich Text EFat Directory 
     *    (RTF with content embedding, on-disk format)
     *
     *    UTI: com.apple.rtfd
     *    conform///  to: com.apple.package, open.composite-content
     *
     *
     *  kUTTypeFlatRTFD
     *
     *    Flattened RTFD (pasteboard format)
     *
     *    UTI: com.apple.flat-rtfd
     *    conform///  to: open.data, open.composite-content
     *
     *
     *  kUTTypeTXNTextAndMultimediaData
     *
     *    MLTE (Textension) format for mixed text & multimedia data
     *    (OSType 'txtn')
     *
     *    UTI: com.apple.txn.text-multimedia-data
     *    conform///  to: open.data, open.composite-content
     *
     *
     *  kUTTypeWebArchive
     *
     *    The WebKit webarchive format
     *
     *    UTI: com.apple.webarchive
     *    conform///  to: open.data, open.composite-content
     */
    @available(iOS 3.0, *)
    public static let PDF = UTType(kUTTypePDF)
    @available(iOS 3.0, *)
    public static let RTFD = UTType(kUTTypeRTFD)
    @available(iOS 3.0, *)
    public static let FlatRTFD = UTType(kUTTypeFlatRTFD)
    @available(iOS 3.0, *)
    public static let TXNTextAndMultimediaData = UTType(kUTTypeTXNTextAndMultimediaData)
    @available(iOS 3.0, *)
    public static let WebArchive = UTType(kUTTypeWebArchive)
    
    /*
     *  kUTTypeImage
     *
     *    abstract image data
     *
     *    UTI: open.image
     *    conform///  to: open.data, open.content
     *
     *
     *  kUTTypeJPEG
     *
     *    JPEG image
     *
     *    UTI: open.jpeg
     *    conform///  to: open.image
     *
     *
     *  kUTTypeJPEG2000
     *
     *    JPEG-2000 image
     *
     *    UTI: open.jpeg-2000
     *    conform///  to: open.image
     *
     *
     *  kUTTypeTIFF
     *
     *    TIFF image
     *
     *    UTI: open.tiff
     *    conform///  to: open.image
     *
     *
     *  kUTTypePICT
     *
     *    Quickdraw PICT format
     *
     *    UTI: com.apple.pict
     *    conform///  to: open.image
     *
     *
     *  kUTTypeGIF
     *
     *    GIF image
     *
     *    UTI: com.compuserve.gif
     *    conform///  to: open.image
     *
     *
     *  kUTTypePNG
     *
     *    PNG image
     *
     *    UTI: open.png
     *    conform///  to: open.image
     *
     *
     *  kUTTypeQuickTimeImage
     *
     *    QuickTime image format (OSType 'qtif')
     *
     *    UTI: com.apple.quicktime-image
     *    conform///  to: open.image
     *
     *
     *  kUTTypeAppleICNS
     *
     *    Apple icon data
     *
     *    UTI: com.apple.icns
     *    conform///  to: open.image
     *
     *
     *  kUTTypeBMP
     *
     *    Windows bitmap
     *
     *    UTI: com.microsoft.bmp
     *    conform///  to: open.image
     *
     *
     *  kUTTypeICO
     *
     *    Windows icon data
     *
     *    UTI: com.microsoft.ico
     *    conform///  to: open.image
     *
     *
     *  kUTTypeRawImage
     *
     *    base type for raw image data (.raw)
     *
     *    UTI: open.camera-raw-image
     *    conform///  to: open.image
     *
     *
     *  kUTTypeScalableVectorGraphics
     *
     *    SVG image
     *
     *    UTI: open.svg-image
     *    conform///  to: open.image
     *
     *  kUTTypeLivePhoto
     *
     *    Live Photo
     *
     *    UTI: com.apple.live-photo
     *
     *
     */
    @available(iOS 3.0, *)
    public static let Image = UTType(kUTTypeImage)
    @available(iOS 3.0, *)
    public static let JPEG = UTType(kUTTypeJPEG)
    @available(iOS 3.0, *)
    public static let JPEG2000 = UTType(kUTTypeJPEG2000)
    @available(iOS 3.0, *)
    public static let TIFF = UTType(kUTTypeTIFF)
    @available(iOS 3.0, *)
    public static let PICT = UTType(kUTTypePICT)
    @available(iOS 3.0, *)
    public static let GIF = UTType(kUTTypeGIF)
    @available(iOS 3.0, *)
    public static let PNG = UTType(kUTTypePNG)
    @available(iOS 3.0, *)
    public static let QuickTimeImage = UTType(kUTTypeQuickTimeImage)
    @available(iOS 3.0, *)
    public static let AppleICNS = UTType(kUTTypeAppleICNS)
    @available(iOS 3.0, *)
    public static let BMP = UTType(kUTTypeBMP)
    @available(iOS 3.0, *)
    public static let ICO = UTType(kUTTypeICO)
    @available(iOS 8.0, *)
    public static let RawImage = UTType(kUTTypeRawImage)
    @available(iOS 8.0, *)
    public static let ScalableVectorGraphics = UTType(kUTTypeScalableVectorGraphics)
    @available(iOS 9.1, *)
    public static let LivePhoto = UTType(kUTTypeLivePhoto)
    
    /*
     *  kUTTypeAudiovisualContent
     *
     *    audio and/or video content
     *
     *    UTI: open.audiovisual-content
     *    conform///  to: open.data, open.content
     *
     *
     *  kUTTypeMovie
     *
     *    A media format which may contain both video and audio
     *    Corresponds to what users would label a "movie"
     *
     *    UTI: open.movie
     *    conform///  to: open.audiovisual-content
     *
     *
     *  kUTTypeVideo
     *
     *    pure video (no audio)
     *
     *    UTI: open.video
     *    conform///  to: open.movie
     *
     *
     *  kUTTypeAudio
     *
     *    pure audio (no video)
     *
     *    UTI: open.audio
     *    conform///  to: open.audiovisual-content
     *
     *
     *  kUTTypeQuickTimeMovie
     *
     *    QuickTime movie
     *
     *    UTI: com.apple.quicktime-movie
     *    conform///  to: open.movie
     *
     *
     *  kUTTypeMPEG
     *
     *    MPEG-1 or MPEG-2 movie
     *
     *    UTI: open.mpeg
     *    conform///  to: open.movie
     *
     *
     *  kUTTypeMPEG2Video
     *
     *    MPEG-2 video
     *
     *    UTI: open.mpeg-2-video
     *    conform///  to: open.video
     *
     *
     *  kUTTypeMPEG2TransportStream
     *
     *    MPEG-2 Transport Stream movie format
     *
     *    UTI: open.mpeg-2-transport-stream
     *    conform///  to: open.movie
     *
     *
     *  kUTTypeMP3
     *
     *    MP3 audio
     *
     *    UTI: open.mp3
     *    conform///  to: open.audio
     *
     *
     *  kUTTypeMPEG4
     *
     *    MPEG-4 movie
     *
     *    UTI: open.mpeg-4
     *    conform///  to: open.movie
     *
     *
     *  kUTTypeMPEG4Audio
     *
     *    MPEG-4 audio layer
     *
     *    UTI: open.mpeg-4-audio
     *    conform///  to: open.mpeg-4, open.audio
     *
     *
     *  kUTTypeAppleProtectedMPEG4Audio
     *
     *    Apple protected MPEG4 format
     *    (.m4p, iTunes music store format)
     *
     *    UTI: com.apple.protected-mpeg-4-audio
     *    conform///  to: open.audio
     *
     *
     *  kUTTypeAppleProtectedMPEG4Video
     *
     *    Apple protected MPEG-4 movie
     *
     *    UTI: com.apple.protected-mpeg-4-video
     *    conforms to: com.apple.m4v-video
     *
     *
     *  kUTTypeAVIMovie
     *
     *    Audio Video Interleaved (AVI) movie format
     *
     *    UTI: open.avi
     *    conform///  to: open.movie
     *
     *
     *  kUTTypeAudioInterchangeFileFormat
     *
     *    AIFF audio format
     *
     *    UTI: open.aiff-audio
     *    conform///  to: open.aifc-audio
     *
     *
     *  kUTTypeWaveformAudio
     *
     *    Waveform audio format (.wav)
     *
     *    UTI: com.microsoft.waveform-audio
     *    conform///  to: open.audio
     *
     *
     *  kUTTypeMIDIAudio
     *
     *    MIDI audio format
     *
     *    UTI: open.midi-audio
     *    conform///  to: open.audio
     *
     *
     */
    @available(iOS 3.0, *)
    public static let AudiovisualContent = UTType(kUTTypeAudiovisualContent)
    @available(iOS 3.0, *)
    public static let Movie = UTType(kUTTypeMovie)
    @available(iOS 3.0, *)
    public static let Video = UTType(kUTTypeVideo)
    @available(iOS 3.0, *)
    public static let Audio = UTType(kUTTypeAudio)
    @available(iOS 3.0, *)
    public static let QuickTimeMovie = UTType(kUTTypeQuickTimeMovie)
    @available(iOS 3.0, *)
    public static let MPEG = UTType(kUTTypeMPEG)
    @available(iOS 8.0, *)
    public static let MPEG2Video = UTType(kUTTypeMPEG2Video)
    @available(iOS 8.0, *)
    public static let MPEG2TransportStream = UTType(kUTTypeMPEG2TransportStream)
    @available(iOS 3.0, *)
    public static let MP3 = UTType(kUTTypeMP3)
    @available(iOS 3.0, *)
    public static let MPEG4 = UTType(kUTTypeMPEG4)
    @available(iOS 3.0, *)
    public static let MPEG4Audio = UTType(kUTTypeMPEG4Audio)
    @available(iOS 3.0, *)
    public static let AppleProtectedMPEG4Audio = UTType(kUTTypeAppleProtectedMPEG4Audio)
    @available(iOS 8.0, *)
    public static let AppleProtectedMPEG4Video = UTType(kUTTypeAppleProtectedMPEG4Video)
    @available(iOS 8.0, *)
    public static let AVIMovie = UTType(kUTTypeAVIMovie)
    @available(iOS 8.0, *)
    public static let AudioInterchangeFileFormat = UTType(kUTTypeAudioInterchangeFileFormat)
    @available(iOS 8.0, *)
    public static let WaveformAudio = UTType(kUTTypeWaveformAudio)
    @available(iOS 8.0, *)
    public static let MIDIAudio = UTType(kUTTypeMIDIAudio)
    
    /*
     *  kUTTypePlaylist
     *
     *    base type for playlists
     *
     *    UTI: open.playlist
     *
     *
     *  kUTTypeM3UPlaylist
     *
     *    M3U or M3U8 playlist
     *
     *    UTI: open.m3u-playlist
     *    conform///  to: open.text, open.playlist
     *
     */
    @available(iOS 8.0, *)
    public static let Playlist = UTType(kUTTypePlaylist)
    @available(iOS 8.0, *)
    public static let M3UPlaylist = UTType(kUTTypeM3UPlaylist)
    
    /*
     *  kUTTypeFolder
     *
     *    a user-browsable directory (i.e., not a package)
     *
     *    UTI: open.folder
     *    conform///  to: open.directory
     *
     *
     *  kUTTypeVolume
     *
     *    the root folder of a volume/mount point
     *
     *    UTI: open.volume
     *    conform///  to: open.folder
     *
     *
     *  kUTTypePackage
     *
     *    a packaged directory
     *
     *    UTI: com.apple.package
     *    conform///  to: open.directory
     *
     *
     *  kUTTypeBundle
     *
     *    a directory conforming to one of the CFBundle layouts
     *
     *    UTI: com.apple.bundle
     *    conform///  to: open.directory
     *
     *
     *  kUTTypePluginBundle
     *
     *    base type for bundle-based plugins
     *
     *    UTI: com.apple.plugin
     *    conforms to: com.apple.bundle, com.apple.package
     *
     *
     *  kUTTypeSpotlightImporter
     *
     *    a Spotlight metadata importer
     *
     *    UTI: com.apple.metadata-importer
     *    conforms to: com.apple.plugin
     *
     *
     *  kUTTypeQuickLookGenerator
     *
     *    a QuickLook preview generator
     *
     *    UTI: com.apple.quicklook-generator
     *    conforms to: com.apple.plugin
     *
     *
     *  kUTTypeXPCService
     *
     *    an XPC service
     *
     *    UTI: com.apple.xpc-service
     *    conforms to: com.apple.bundle, com.apple.package
     *
     *
     *  kUTTypeFramework
     *
     *    a Mac OS X framework
     *
     *    UTI: com.apple.framework
     *    conforms to: com.apple.bundle
     *
     */
    @available(iOS 3.0, *)
    public static let Folder = UTType(kUTTypeFolder)
    @available(iOS 3.0, *)
    public static let Volume = UTType(kUTTypeVolume)
    @available(iOS 3.0, *)
    public static let Package = UTType(kUTTypePackage)
    @available(iOS 3.0, *)
    public static let Bundle = UTType(kUTTypeBundle)
    @available(iOS 8.0, *)
    public static let PluginBundle = UTType(kUTTypePluginBundle)
    @available(iOS 8.0, *)
    public static let SpotlightImporter = UTType(kUTTypeSpotlightImporter)
    @available(iOS 8.0, *)
    public static let QuickLookGenerator = UTType(kUTTypeQuickLookGenerator)
    @available(iOS 8.0, *)
    public static let XPCService = UTType(kUTTypeXPCService)
    @available(iOS 3.0, *)
    public static let Framework = UTType(kUTTypeFramework)
    
    /*
     *  kUTTypeApplication
     *
     *    base type for OS X applications, launchable items
     *
     *    UTI: com.apple.application
     *    conform///  to: open.executable
     *
     *
     *  kUTTypeApplicationBundle
     *
     *    a bundled application
     *
     *    UTI: com.apple.application-bundle
     *    conforms to: com.apple.application, com.apple.bundle, com.apple.package
     *
     *
     *  kUTTypeApplicationFile
     *
     *    a single-file Carbon/Classic application 
     *
     *    UTI: com.apple.application-file
     *    conform///  to: com.apple.application, open.data
     *
     *
     *  kUTTypeUnixExecutable
     *
     *    a UNIX executable (flat file)
     *
     *    UTI: open.unix-executable
     *    conform///  to: open.data, open.executable
     *
     *
     *  kUTTypeWindowsExecutable
     *
     *    a Windows executable (.exe files)
     *
     *    UTI: com.microsoft.windows-executable
     *    conform///  to: open.data, open.executable
     *
     *
     *  kUTTypeJavaClass
     *
     *    a Java public class
     *
     *    UTI: com./// un.java-public class
     *    conform///  to: open.data, open.executable
     *
     *
     *  kUTTypeJavaArchive
     *
     *    a Java archive (.jar)
     *
     *    UTI: com.sun.java-archive
     *    conform///  to: open.zip-archive, open.executable
     *
     *
     *  kUTTypeSystemPreferencesPane
     *
     *    a System Preferences pane
     *
     *    UTI: com.apple.systempreference.prefpane
     *    conforms to: com.apple.package, com.apple.bundle
     *
     */
    // Abstract executable types
    @available(iOS 3.0, *)
    public static let Application = UTType(kUTTypeApplication)
    @available(iOS 3.0, *)
    public static let ApplicationBundle = UTType(kUTTypeApplicationBundle)
    @available(iOS 3.0, *)
    public static let ApplicationFile = UTType(kUTTypeApplicationFile)
    @available(iOS 8.0, *)
    public static let UnixExecutable = UTType(kUTTypeUnixExecutable)
    
    // Other platform binaries
    @available(iOS 8.0, *)
    public static let WindowsExecutable = UTType(kUTTypeWindowsExecutable)
    @available(iOS 8.0, *)
    public static let JavaClass = UTType(kUTTypeJavaClass)
    @available(iOS 8.0, *)
    public static let JavaArchive = UTType(kUTTypeJavaArchive)
    
    // Misc. binaries
    @available(iOS 8.0, *)
    public static let SystemPreferencesPane = UTType(kUTTypeSystemPreferencesPane)
    
    /*
     *  kUTTypeGNUZipArchive
     *
     *    a GNU zip archive (gzip)
     *
     *    UTI: org.gnu.gnu-zip-archive
     *    conform///  to: open.data, open.archive
     *
     *
     *  kUTTypeBzip2Archive
     *
     *    a bzip2 archive (.bz2)
     *
     *    UTI: open.bzip2-archive
     *    conform///  to: open.data, open.archive
     *
     *
     *  kUTTypeZipArchive
     *
     *    a zip archive
     *
     *    UTI: open.zip-archive
     *    conforms to: com.pkware.zip-archive
     *
     */
    @available(iOS 8.0, *)
    public static let GNUZipArchive = UTType(kUTTypeGNUZipArchive)
    @available(iOS 8.0, *)
    public static let Bzip2Archive = UTType(kUTTypeBzip2Archive)
    @available(iOS 8.0, *)
    public static let ZipArchive = UTType(kUTTypeZipArchive)
    
    /*
     *  kUTTypeSpreadsheet
     *
     *    base spreadsheet document type
     *
     *    UTI: open.spreadsheet
     *    conform///  to: open.content
     *
     *
     *  kUTTypePresentation
     *
     *    base presentation document type
     *
     *    UTI: open.presentation
     *    conform///  to: open.composite-content
     *
     *
     *  kUTTypeDatabase
     *
     *    a database store
     *
     *    UTI: open.database
     *
     */
    @available(iOS 8.0, *)
    public static let Spreadsheet = UTType(kUTTypeSpreadsheet)
    @available(iOS 8.0, *)
    public static let Presentation = UTType(kUTTypePresentation)
    @available(iOS 8.0, *)
    public static let Database = UTType(kUTTypeDatabase)
    
    /*
     *  kUTTypeVCard
     *
     *    VCard format
     *
     *    UTI: open.vcard
     *    conform///  to: open.text, open.contact
     *
     *
     *  kUTTypeToDoItem
     *
     *    to-do item
     *
     *    UTI: open.to-do-item
     *
     *
     *  kUTTypeCalendarEvent
     *
     *    calendar event
     *
     *    UTI: open.calendar-event
     *
     *
     *  kUTTypeEmailMessage
     *
     *    e-mail message
     *
     *    UTI: open.email-message
     *    conform///  to: open.message
     *
     */
    @available(iOS 3.0, *)
    public static let VCard = UTType(kUTTypeVCard)
    @available(iOS 8.0, *)
    public static let ToDoItem = UTType(kUTTypeToDoItem)
    @available(iOS 8.0, *)
    public static let CalendarEvent = UTType(kUTTypeCalendarEvent)
    @available(iOS 8.0, *)
    public static let EmailMessage = UTType(kUTTypeEmailMessage)
    
    /*
     *  kUTTypeInternetLocation
     *
     *    base type for Apple Internet locations
     *
     *    UTI: com.apple.internet-location
     *    conform///  to: open.data
     *
     */
    @available(iOS 8.0, *)
    public static let InternetLocation = UTType(kUTTypeInternetLocation)
    
    /*
     *  kUTTypeInkText
     *
     *    Opaque InkText data
     *
     *    UTI: com.apple.ink.inktext
     *    conform///  to: open.data
     *
     *
     *  kUTTypeFont
     *
     *    base type for fonts
     *
     *    UTI: open.font
     *
     *
     *  kUTTypeBookmark
     *
     *    bookmark
     *
     *    UTI: open.bookmark
     *
     *
     *  kUTType3DContent
     *
     *    base type for 3D content
     *
     *    UTI: open.3d-content
     *    conform///  to: open.content
     *
     *
     *  kUTTypePKCS12
     *
     *    PKCS#12 format
     *
     *    UTI: com.rsa.pkcs-12
     *    conform///  to: open.data
     *
     *
     *  kUTTypeX509Certificate
     *
     *    X.509 certificate format
     *
     *    UTI: open.x509-certificate
     *    conform///  to: open.data
     *
     *
     *  kUTTypeElectronicPublication
     *
     *    ePub format
     *
     *    UTI: org.idpf.epub-container
     *    conform///  to: open.data, open.composite-content
     *
     *
     *  kUTTypeLog
     *
     *    console log
     *
     *    UTI: open.log
     *
     */
    @available(iOS 3.0, *)
    public static let InkText = UTType(kUTTypeInkText)
    @available(iOS 8.0, *)
    public static let Font = UTType(kUTTypeFont)
    @available(iOS 8.0, *)
    public static let Bookmark = UTType(kUTTypeBookmark)
    @available(iOS 8.0, *)
    public static let _3DContent = UTType(kUTType3DContent)
    @available(iOS 8.0, *)
    public static let PKCS12 = UTType(kUTTypePKCS12)
    @available(iOS 8.0, *)
    public static let X509Certificate = UTType(kUTTypeX509Certificate)
    @available(iOS 8.0, *)
    public static let ElectronicPublication = UTType(kUTTypeElectronicPublication)
    @available(iOS 8.0, *)
    public static let Log = UTType(kUTTypeLog)
    
    // MARK: - ** Constructor Methods ** -
    
    public init(rawValue: RawValue) {
        self.rawValue = rawValue
    }
    
    public init(_ rawValue: RawValue) {
        self.rawValue = rawValue
    }
    
    public init(coreValue: CoreValue) {
        rawValue = coreValue as String
    }
    
    public init(_ coreValue: CoreValue) {
        rawValue = coreValue as String
    }
    
    // MARK: - ** Public Methods ** -
    
    /// Returns whether or not `self` is an unknown UTType.
    /// - returns: `true` if `self == UTType.Unknown`; `false` otherwise.
    public func isUnknown() -> Bool {
        return self == .Unknown
    }
    
    /// Returns whether or not `self` is not an unknown UTType.
    /// - returns: `true` if `self != UTType.Unknown`; `false` otherwise.
    public func isNotUnknown() -> Bool {
        return self != .Unknown
    }
    
    /// Checks whether or not `self` conforms to `uttype`.
    /// - parameter uttype: The UTType to compare against.
    /// - returns: `true` if `self` conforms to `uttype`; `false` otherwise.
    public func conformsTo(_ uttype: UTType) -> Bool {
        return UTTypeConformsTo(coreValue, uttype.coreValue)
    }
    
}
