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

extension String {

    ///
    public enum LineEnding: String {
        
        public typealias Value = String

        case CR
        case LF
        case CRLF
        
        public var value: Value {
            switch self {
            case .CR:
                return "\r"
            case .LF:
                return "\n"
            case .CRLF:
                return "\r\n"
            }
        }
        
        fileprivate static func values() -> [String: LineEnding] {
            return [
                CR.rawValue     : CR,
                LF.rawValue     : LF,
                CRLF.rawValue   : CRLF,
            ]
        }
        
        public init(stringValue: String?) {
            guard let stringValue = stringValue else { self = .LF; return }
            self = LineEnding.values()[stringValue] ?? .LF
        }
        
    }

}
