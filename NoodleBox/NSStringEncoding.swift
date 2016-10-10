//
//  NSStringEncoding.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 6/2/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import Foundation

extension String.Encoding {
    
    public var stringValue: String {
        guard let index = String.Encoding.values().values.index(of: self) else { return "" }
        return String.Encoding.values().keys[index] ?? ""
    }

    fileprivate static func values() -> [String : String.Encoding] {
        return [
            "ASCIIStringEncoding"             : String.Encoding.ascii,
            "NEXTSTEPStringEncoding"          : String.Encoding.nextstep,
            "JapaneseEUCStringEncoding"       : String.Encoding.japaneseEUC,
            "UTF8StringEncoding"              : String.Encoding.utf8,
            "ISOLatin1StringEncoding"         : String.Encoding.isoLatin1,
            "SymbolStringEncoding"            : String.Encoding.symbol,
            "NonLossyASCIIStringEncoding"     : String.Encoding.nonLossyASCII,
            "ShiftJISStringEncoding"          : String.Encoding.shiftJIS,
            "ISOLatin2StringEncoding"         : String.Encoding.isoLatin2,
            "UnicodeStringEncoding"           : String.Encoding.unicode,
            "WindowsCP1251StringEncoding"     : String.Encoding.windowsCP1251,
            "WindowsCP1252StringEncoding"     : String.Encoding.windowsCP1252,
            "WindowsCP1253StringEncoding"     : String.Encoding.windowsCP1253,
            "WindowsCP1254StringEncoding"     : String.Encoding.windowsCP1254,
            "WindowsCP1250StringEncoding"     : String.Encoding.windowsCP1250,
            "ISO2022JPStringEncoding"         : String.Encoding.iso2022JP,
            "MacOSRomanStringEncoding"        : String.Encoding.macOSRoman,
            "UTF16StringEncoding"             : String.Encoding.utf16,
            "UTF16BigEndianStringEncoding"    : String.Encoding.utf16BigEndian,
            "UTF16LittleEndianStringEncoding" : String.Encoding.utf16LittleEndian,
            "UTF32StringEncoding"             : String.Encoding.utf32,
            "UTF32BigEndianStringEncoding"    : String.Encoding.utf32BigEndian,
            "UTF32LittleEndianStringEncoding" : String.Encoding.utf32LittleEndian,
            "ProprietaryStringEncoding"       : String.Encoding(rawValue: NSProprietaryStringEncoding),
        ]
    }

    public init(stringValue: String?) {
        guard let stringValue = stringValue else { self = String.Encoding.utf8; return }
        self = String.Encoding.values()[stringValue] ?? String.Encoding.utf8
    }

}
