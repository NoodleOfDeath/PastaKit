//
//  NSStringEncoding.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 6/2/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import Foundation

extension NSStringEncoding {
    
    public var stringValue: String {
        guard let index = NSStringEncoding.values().values.indexOf(self) else { return "" }
        return NSStringEncoding.values().keys[index] ?? ""
    }

    private static func values() -> [String : NSStringEncoding] {
        return [
            "ASCIIStringEncoding"             : NSASCIIStringEncoding,
            "NEXTSTEPStringEncoding"          : NSNEXTSTEPStringEncoding,
            "JapaneseEUCStringEncoding"       : NSJapaneseEUCStringEncoding,
            "UTF8StringEncoding"              : NSUTF8StringEncoding,
            "ISOLatin1StringEncoding"         : NSISOLatin1StringEncoding,
            "SymbolStringEncoding"            : NSSymbolStringEncoding,
            "NonLossyASCIIStringEncoding"     : NSNonLossyASCIIStringEncoding,
            "ShiftJISStringEncoding"          : NSShiftJISStringEncoding,
            "ISOLatin2StringEncoding"         : NSISOLatin2StringEncoding,
            "UnicodeStringEncoding"           : NSUnicodeStringEncoding,
            "WindowsCP1251StringEncoding"     : NSWindowsCP1251StringEncoding,
            "WindowsCP1252StringEncoding"     : NSWindowsCP1252StringEncoding,
            "WindowsCP1253StringEncoding"     : NSWindowsCP1253StringEncoding,
            "WindowsCP1254StringEncoding"     : NSWindowsCP1254StringEncoding,
            "WindowsCP1250StringEncoding"     : NSWindowsCP1250StringEncoding,
            "ISO2022JPStringEncoding"         : NSISO2022JPStringEncoding,
            "MacOSRomanStringEncoding"        : NSMacOSRomanStringEncoding,
            "UTF16StringEncoding"             : NSUTF16StringEncoding,
            "UTF16BigEndianStringEncoding"    : NSUTF16BigEndianStringEncoding,
            "UTF16LittleEndianStringEncoding" : NSUTF16LittleEndianStringEncoding,
            "UTF32StringEncoding"             : NSUTF32StringEncoding,
            "UTF32BigEndianStringEncoding"    : NSUTF32BigEndianStringEncoding,
            "UTF32LittleEndianStringEncoding" : NSUTF32LittleEndianStringEncoding,
            "ProprietaryStringEncoding"       : NSProprietaryStringEncoding,
        ]
    }

    public init(stringValue: String?) {
        guard let stringValue = stringValue else { self = NSUTF8StringEncoding; return }
        self = NSStringEncoding.values()[stringValue] ?? NSUTF8StringEncoding
    }

}
