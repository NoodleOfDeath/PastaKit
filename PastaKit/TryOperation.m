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







