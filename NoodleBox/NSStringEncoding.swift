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

extension String.Encoding {
    
    public var stringValue: String {
        guard let index = String.Encoding.values().values.index(of: self) else { return "" }
        return String.Encoding.values().keys[index]
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
