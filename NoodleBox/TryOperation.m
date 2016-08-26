//
//  TryOperation.m
//  NoodleBox
//
//  Created by NoodleOfDeath on 7/6/16.
//  Copyright © 2016 NoodleNation. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TryOperation.h"

@implementation TryOperation

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

@end







