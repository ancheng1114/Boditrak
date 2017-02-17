//
//  Cop.m
//  BodiTrak
//
//  Created by AnCheng on 9/27/16.
//  Copyright © 2016 AnCheng. All rights reserved.
//

#import "Cop.h"

#define NOISEFLOOR 0.0f

@implementation SensorArray

@end

@implementation Frame

- (id)init
{
    self = [super init];
    if (self)
    {

        _values = [NSMutableArray new];
    }
    
    return self;
}

@end

@implementation Cop

+ (id)sharedManager
{
    static Cop *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[super alloc] init];
    });
    return sharedManager;
}

- (void)getCenterOfPressure:(Frame *)frame
{
    int c,r;
    float w = 0,x = 0 , y = 0;

    for (r = 0 ; r < _sensor.rows ; r++)
    {
        for (c = 0 ; c < _sensor.columns ; c++)
        {
            float val = [[frame.values objectAtIndex:(r * _sensor.columns + c)] floatValue];
            if (val > NOISEFLOOR){
                
                w += val;
                x += val * (c + 0.5f);
                y += val * (r + 0.5f);
            }
        }
    }
    
    frame.cop = CGPointMake((w == 0 ? 0.5f : y / w / _sensor.rows) ,(w == 0 ? 0.5f : x / w / _sensor.columns));

}

- (void)getCenterOfPressureTopHalf:(Frame *)frame
{
    
    int c,r;
    float w = 0,x = 0 , y = 0;
    
    for (r = 0 ; r < _sensor.rows / 2 ; r++)
    {
        for (c = 0 ; c < _sensor.columns ; c++)
        {
            float val = [[frame.values objectAtIndex:(r * _sensor.columns + c)] floatValue];
            if (val > NOISEFLOOR){
                
                w += val;
                x += val * (c + 0.5f);
                y += val * (_sensor.rows - r - 0.5f);
            }
            
        }
        
    }
    
    frame.copTop = w;

}

- (void)getCenterOfPressureBottomHalf:(Frame *)frame
{
    
    int c,r;
    float w = 0,x = 0 , y = 0;
    
    for (r = _sensor.rows / 2 ; r < _sensor.rows ; r++)
    {
        for (c = 0 ; c < _sensor.columns ; c++)
        {
            float val = [[frame.values objectAtIndex:(r * _sensor.columns + c)] floatValue];
            if (val > NOISEFLOOR){
                
                w += val;
                x += val * (c + 0.5f);
                y += val * (_sensor.rows - r - 0.5f);
            }
            
        }
        
    }
    
    frame.copBottom = w;
}

@end
