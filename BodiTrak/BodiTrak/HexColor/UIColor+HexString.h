//
//  UIColor+HexString.h
//  MutableDemo
//
//  Created by ancheng1114 on 5/15/14.
//  Copyright (c) 2014 ancheng1114. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexString)

+ (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length;
+ (UIColor *) colorWithHexString: (NSString *) hexString;

@end
