//
//  TryOperation.m
//  NoodleBox
//
//  Created by NoodleOfDeath on 7/6/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TryOperation.h"

static BOOL showedDefaultCatchWarning = false;

@implementation TryOperation {
    
    void(^_tryBlock)(void);
    void(^_catchBlock)(NSException *);
    void(^_finallyBlock)(void);
}

+ (void)runWithBlock:(void (^)())tryBlock {
    [self runWithBlock: tryBlock catchBlock: nil finallyBlock: nil];
}

+ (void)runWithBlock:(void (^)())tryBlock catchBlock:(void (^)(NSException *))catchBlock {
    [self runWithBlock: tryBlock catchBlock : catchBlock finallyBlock: nil];
}

+ (void)runWithBlock:(void (^)())tryBlock catchBlock:(void (^)(NSException *))catchBlock finallyBlock:(void (^)())finallyBlock {
    @try {
        tryBlock ? tryBlock() : nil;
    }
    @catch (NSException *e) {
        catchBlock ? catchBlock(e) : nil;
    }
    @finally {
        finallyBlock ? finallyBlock() : nil;
    }
}

- (instancetype)initWithBlock:(void (^)())tryBlock {
    return [self initWithBlock: tryBlock catchBlock: nil finallyBlock: nil delayExecution: 0];
}

- (instancetype)initWithBlock:(void (^)())tryBlock catchBlock:(void (^)(NSException *))catchBlock {
    return [self initWithBlock: tryBlock catchBlock: catchBlock finallyBlock: nil delayExecution: 0];
}

- (instancetype)initWithBlock:(void (^)())tryBlock catchBlock:(void (^)(NSException *))catchBlock finallyBlock:(void (^)())finallyBlock {
    return [self initWithBlock: tryBlock catchBlock: catchBlock finallyBlock: finallyBlock delayExecution: 0];
}

- (instancetype)initWithBlock:(void (^)())tryBlock delayExecution:(int)delay {
    return [self initWithBlock: tryBlock catchBlock: nil finallyBlock: nil delayExecution: delay];
}

- (instancetype)initWithBlock:(void (^)())tryBlock catchBlock:(void (^)(NSException *))catchBlock delayExecution:(int)delay {
    return [self initWithBlock: tryBlock catchBlock: catchBlock finallyBlock: nil delayExecution: delay];
}
- (instancetype)initWithBlock:(void (^)())tryBlock catchBlock:(void (^)(NSException *))catchBlock finallyBlock:(void (^)())finallyBlock delayExecution:(int)delay {
    if (self == [super init]) {
        _tryBlock = tryBlock;
        _catchBlock = catchBlock;
        _finallyBlock = finallyBlock;
        if (delay >= 0) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [self run];
            });
        }
    }
    return self;
}

- (void)run {
    @try {
        _tryBlock ? _tryBlock() : nil;
    }
    @catch (NSException *e) {
        _catchBlock ? _catchBlock(e) : [self catchException: e];
    }
    @finally {
        _finallyBlock ? _finallyBlock() : nil;
    }
}

- (void)catchException:(NSException *) exception {
    if (!showedDefaultCatchWarning) {
    NSLog(@"Running default exception catch block. Your application should supply its own catch block before release that handles specific exceptions. This warning will only appear once per session.");
    }
    NSLog(@"Printing stack trace");
    NSArray<NSString *> *symbols = [exception callStackSymbols];
    for (int i = 0; i < [symbols count]; ++i)
        NSLog(@"%@", symbols[i]);
}

@end







