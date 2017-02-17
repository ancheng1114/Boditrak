//
//  CopVelocityView.m
//  BodiTrak
//
//  Created by AnCheng on 9/27/16.
//  Copyright © 2016 AnCheng. All rights reserved.
//

#import "CopVelocityView.h"

@implementation CopVelocityView

- (id)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame])
    {
        _copArr = [NSMutableArray new];

    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self == [super initWithCoder:aDecoder])
    {
        _copArr = [NSMutableArray new];
    }
    
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    // draw _prev2Frame copVelocity and copVelocity1
    
    if (_copArr.count > 2)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();

        CGContextSetLineWidth(context, 1.0f);
        
        for (int i = 0 ; i < _copArr.count - 1 ; i ++)
        {
            NSArray *arr = [_copArr objectAtIndex:i];
            NSArray *arr1 = [_copArr objectAtIndex:i + 1];
            
            NSDate *time = [arr objectAtIndex:2];
            NSDate *time1 = [arr1 objectAtIndex:2];
            
            float pointTop = [[arr objectAtIndex:0] floatValue];
            float pointTop1 = [[arr1 objectAtIndex:0] floatValue];
            
            float pointBottom = [[arr objectAtIndex:1] floatValue];
            float pointBottom1 = [[arr1 objectAtIndex:1] floatValue];
            
            CGContextSetStrokeColorWithColor(context, [UIColor colorWithHexString:@"#4BACC6"].CGColor);
            CGContextMoveToPoint(context, (1 - [_currentFrame.frameTime timeIntervalSinceDate:time] / 2.0f) * rect.size.width, rect.size.height / 2.0f - pointTop / 15.0f);
            CGContextAddLineToPoint(context, (1 - [_currentFrame.frameTime timeIntervalSinceDate:time1] / 2.0f) * rect.size.width, rect.size.height / 2.0f - pointTop1 / 15.0f);
            CGContextStrokePath(context);
            
            CGContextSetStrokeColorWithColor(context, [UIColor yellowColor].CGColor);
            CGContextMoveToPoint(context, (1 - [_currentFrame.frameTime timeIntervalSinceDate:time] / 2.0f) * rect.size.width, rect.size.height / 2.0f - pointBottom / 15.0f);
            CGContextAddLineToPoint(context, (1 - [_currentFrame.frameTime timeIntervalSinceDate:time1] / 2.0f) * rect.size.width, rect.size.height / 2.0f - pointBottom1 / 15.0f);
            CGContextStrokePath(context);
            
            CGContextSetStrokeColorWithColor(context, [UIColor orangeColor].CGColor);
            CGContextMoveToPoint(context, (1 - [_currentFrame.frameTime timeIntervalSinceDate:time] / 2.0f) * rect.size.width, rect.size.height / 2.0f - (pointBottom + pointTop) / 15.0f);
            CGContextAddLineToPoint(context, (1 - [_currentFrame.frameTime timeIntervalSinceDate:time1] / 2.0f) * rect.size.width, rect.size.height / 2.0f - (pointBottom1 + pointTop) / 15.0f);
            CGContextStrokePath(context);
        }
        
    }
}

- (void)setMatFrame:(Frame *)frame
{
    _currentFrame = frame;
    [_copArr addObject:@[@(frame.copTop) , @(frame.copBottom) , frame.frameTime]];
    for (int i = 0 ; i < _copArr.count ; i ++)
    {
        NSArray *arr = [_copArr objectAtIndex:i];
        NSDate *time = [arr objectAtIndex:2];
        
        if ([_currentFrame.frameTime timeIntervalSinceDate:time] > 2)
            [_copArr removeObjectAtIndex:i];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{

        [self setNeedsDisplay];
    });
}

@end
