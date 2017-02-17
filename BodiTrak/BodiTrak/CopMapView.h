//
//  CopMapView.h
//  BodiTrak
//
//  Created by AnCheng on 9/27/16.
//  Copyright © 2016 AnCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CopMapView : UIView
{
    
    CGPoint currentPoint; //current frame
    CGPoint candidatePoint; //candidate frame
    CGPoint stillPoint; //still frame

    NSDate *candidateTime;
    NSInteger candidateIndex;

}

@property (nonatomic ,strong) Frame *matFrame;
@property (nonatomic ,strong) NSMutableArray *traceArr;
@property (nonatomic ,strong) SensorArray *sensor;

- (void)setMatFrame:(Frame *)frame;

@end
