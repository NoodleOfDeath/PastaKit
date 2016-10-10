//
//  NSStringLineEnding.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 6/11/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import Foundation

public enum NSStringLineEnding: String {
    
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
    
    fileprivate static func values() -> [String: NSStringLineEnding] {
        return [
            CR.rawValue     : CR,
            LF.rawValue     : LF,
            CRLF.rawValue   : CRLF,
        ]
    }
    
    public init(stringValue: String?) {
        guard let stringValue = stringValue else { self = .LF; return }
        self = NSStringLineEnding.values()[stringValue] ?? .LF
    }
    
}
