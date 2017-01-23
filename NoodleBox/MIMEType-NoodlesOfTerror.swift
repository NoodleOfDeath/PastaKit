//
//  MIMEType.swift
//  NoodleBox
//
//  Created by Thom Morgan on 9/13/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import Foundation

public enum MIMEType : String {
    
    case JPEG       = "image/jpeg"
    case PNG        = "image/png"
    case GIF        = "image/gig"
    case TIFF       = "image/tiff"
    case PDF        = "application/pdf"
    case VND        = "application/vnd"
    case PlainText  = "text/plain"
    case Binary     = "application/octet-stream"
    
    public init(byteOffset: UInt8) {
        
        switch (byteOffset) {
            
        case 0xFF:
            self = .JPEG
            break
            
        case 0x89:
            self = .PNG
            break
            
        case 0x47:
            self = .GIF
            break
            
        case 0x49, 0x4D:
            self = .TIFF
            break
            
        case 0x25:
            self = .PDF
            break
            
        case 0xD0:
            self = .VND
            break
            
        case 0x46:
            self = .PlainText
            break
            
        default:
            self = .Binary
            break
            
        }
        
    }
    
}
