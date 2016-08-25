//
//  TryOperation.h
//  ByteMe
//
//  Created by Thom Morgan on 7/6/16.
//  Copyright © 2016 Muxcode. All rights reserved.
//

#ifndef TryOperation_h
#define TryOperation_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TryOperation : NSObject

+ (void)runWithBlock:(void (^)())tryBlock;
+ (void)runWithBlock:(void (^)())tryBlock catchBlock:(void (^)(NSException *))catchBlock;
+ (void)runWithBlock:(void (^)())tryBlock catchBlock:(void (^)(NSException *))catchBlock finallyBlock:(void (^)())finallyBlock;

@end

#endif /* TryOperation_h */
