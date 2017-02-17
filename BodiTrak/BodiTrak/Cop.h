//
//  Cop.h
//  BodiTrak
//
//  Created by AnCheng on 9/27/16.
//  Copyright © 2016 AnCheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SensorArray : NSObject

@property (nonatomic) int columns;
@property (nonatomic) int rows;
@property (nonatomic) float width;
@property (nonatomic) float height;

@end

@interface Frame : NSObject

@property (nonatomic) NSMutableArray *values;
@property (nonatomic) NSInteger frameid;
@property (nonatomic ,strong) NSDate *frameTime;
@property (nonatomic ,strong) NSString *timeStr;

@property (nonatomic) CGPoint cop;

@property (nonatomic) float copTop;
@property (nonatomic) float copBottom;

@property (nonatomic) CGPoint copVelocity;
@property (nonatomic) CGPoint copVelocity1;

@end

@class SensorArray;
@class Frame;

@interface Cop : NSObject

@property (nonatomic ,strong) SensorArray *sensor;

+ (id)sharedManager;

- (void)getCenterOfPressure:(Frame *)frame;
- (void)getCenterOfPressureTopHalf:(Frame *)frame;
- (void)getCenterOfPressureBottomHalf:(Frame *)frame;

@end
