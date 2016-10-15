//
//  StringAnyMapCoding.swift
//  NoodleBox
//
//  Created by Thom Morgan on 10/15/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import Foundation

public protocol StringAnyMapCoding {
    init?(dict: [String : Any])
    var dictionaryForm: [String : Any] { get }
}
