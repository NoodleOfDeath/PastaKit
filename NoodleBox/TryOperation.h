//
//  TryOperation.h
//  NoodleBox
//
//  Created by NoodleOfDeath on 7/6/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

#ifndef TryOperation_h
#define TryOperation_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 A code block manager that execeures blocks that may throw Objective-C
 execptions not normally visible to the Swift module. For example,
 the NSKeyUnarchiver.unarchiveObjectWithFile(_:String) Swift method will
 throw an NSException if the file is not a valid archive, causing the
 application to crash. This allows for elegant exception handling.
 @note: Exceptions should be handled on a specific basis, and the default
 catch block should only be used during the debugging deployment phase.
 */
@interface TryOperation : NSObject

/** 
 Trys a code block and ignores Objective-C thrown exceptions 
 not always visible to the Swift module preventing the app from crashing.
 A stack trace will be printed to the console if an exception is thrown.
 @note: Thrown exceptions should still be handles using an alternative
 method!
 @param tryBlock: The code block to observe for thrown exceptions.
 */
+ (void)runWithBlock:(void (^)())tryBlock;

/** 
 Catches Objective-C thrown exceptions not always visible to the Swift module.
 The block will execute immediately upon initialization.
 @param tryBlock: The code block to observe for thrown exceptions.
 @param catchBlock: The code to run when an exception is thrown.
 */
+ (void)runWithBlock:(void (^)())tryBlock catchBlock:(void (^)(NSException *))catchBlock;

/** 
 Catches Objective-C thrown exceptions not always visible to the Swift module.
 The block will execute immediately upon initialization.
 @param tryBlock: The code block to observe for thrown exceptions.
 @param catchBlock: The code to run when an exception is thrown.
 @param finallyBlock: The code to run after the entire tryBlock and catchBlock
 have finished executing.
 */
+ (void)runWithBlock:(void (^)())tryBlock catchBlock:(void (^)(NSException *))catchBlock finallyBlock:(void (^)())finallyBlock;

/** 
 Trys a code block and ignores Objective-C thrown exceptions 
 not always visible to the Swift module preventing the app from crashing.
 A stack trace will be printed to the console if an exception is thrown.
 @note: Thrown exceptions should still be handles using an alternative
 method!
 @param tryBlock: The code block to observe for thrown exceptions.
 @return: A code block manager that can be run and catches Objective-C thrown
 execeptions.
 */
- (instancetype)initWithBlock:(void (^)())tryBlock;

/** 
 Catches Objective-C thrown exceptions not always visible to the Swift module.
 The block will execute immediately upon initialization.
 @param tryBlock: The code block to observe for thrown exceptions.
 @param catchBlock: The code to run when an exception is thrown.
 @return A code block manager that can be run and catches Objective-C thrown
 execeptions.
 */
- (instancetype)initWithBlock:(void (^)())tryBlock catchBlock:(void (^)(NSException *))catchBlock;

/** 
 Catches Objective-C thrown exceptions not always visible to the Swift module.
 The block will execute immediately upon initialization.
 @param tryBlock: The code block to observe for thrown exceptions.
 @param catchBlock: The code to run when an exception is thrown.
 @param finallyBlock: The code to run after the entire tryBlock and catchBlock
 have finished executing.
 @return A code block manager that can be run and catches Objective-C thrown
 execeptions.
 */
- (instancetype)initWithBlock:(void (^)())tryBlock catchBlock:(void (^)(NSException *))catchBlock finallyBlock:(void (^)())finallyBlock;

/** 
 Trys a code block and ignores Objective-C thrown exceptions 
 not always visible to the Swift module preventing the app from crashing.
 A stack trace will be printed to the console if an exception is thrown.
 @note: Thrown exceptions should still be handles using an alternative
 method!
 @param tryBlock: The code block to observe for thrown exceptions.
 @param delay: The amount of time to delay execution in seconds after
 initialization. If any value less than `0` is used the block will require
 manual execution by calling the `run` method on the instance. The default
 delay value is set to `0`, which executes immediately after initialization.
 @return: A code block manager that can be run and catches Objective-C thrown
 execeptions.
 */
- (instancetype)initWithBlock:(void (^)())tryBlock delayExecution:(int)delay;

/** 
 Catches Objective-C thrown exceptions not always visible to the Swift module.
 @param tryBlock: The code block to observe for thrown exceptions.
 @param catchBlock: The code to run when an exception is thrown.
 @param delay: The amount of time to delay execution in seconds after
 initialization. If any value less than `0` is used the block will require
 manual execution by calling the `run` method on the instance. The default
 delay value is set to `0`, which executes immediately after initialization.
 @return: A code block manager that can be run and catches Objective-C thrown
 execeptions.
 */
- (instancetype)initWithBlock:(void (^)())tryBlock catchBlock:(void (^)(NSException *))catchBlock delayExecution:(int)delay;

/** 
 Catches Objective-C thrown exceptions not always visible to the Swift module.
 @param tryBlock: The code block to observe for thrown exceptions.
 @param catchBlock: The code to run when an exception is thrown.
 @param finallyBlock: The code to run after the entire tryBlock and catchBlock
 have finished executing.
 @param delay: The amount of time to delay execution in seconds after
 initialization. If any value less than `0` is used the block will require
 manual execution by calling the `run` method on the instance. The default
 delay value is set to `0`, which executes immediately after initialization.
 @return: A code block manager that can be run and catches Objective-C thrown
 execeptions.
 */
- (instancetype)initWithBlock:(void (^)())tryBlock catchBlock:(void (^)(NSException *))catchBlock finallyBlock:(void (^)())finallyBlock delayExecution:(int)delay;

/**
 Runs the `tryBlock` and attempts to catch an thrown exceptions. This can
 be called repeatedly on a retained `TryOperation` instance.
 "Insanity is doing the same thing over and over expecting different results."
 */
- (void)run;

@end

#endif /* TryOperation_h */
