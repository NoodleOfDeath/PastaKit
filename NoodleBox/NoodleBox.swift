//
//  NoodleBox.swift
//  NoodleBox
//
//  Created by NoodleOfDeath on 3/6/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

import UIKit

// Convenient Constants

public let NSResourcePath: String! = NSBundle.mainBundle().resourcePath!
public let NSDocumentPath: String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]

public let NSUbiquityURL: NSURL?  = NSFileManager.defaultManager().URLForUbiquityContainerIdentifier(nil)
public let NSUbiquityPath: String? = NSUbiquityURL?.path

public let NSCloudDocsURL: NSURL? = NSUbiquityURL +/ "Documents"
public let NSCloudDocsPath: String? = NSCloudDocsURL?.path

public let NSInboxDocPath: String = NSDocumentPath +/ "Inbox"
public let NSUserDocsPath: String = NSDocumentPath +/ "UserDocuments"

public let NSTmpFilesPath: String = NSTemporaryDirectory()
public let NSAppSpprtPath: String = NSSearchPathForDirectoriesInDomains(.ApplicationSupportDirectory, .UserDomainMask, true)[0]