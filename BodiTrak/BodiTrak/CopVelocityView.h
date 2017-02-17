//
//  CopVelocityView.h
//  BodiTrak
//
//  Created by AnCheng on 9/27/16.
//  Copyright © 2016 AnCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CopVelocityView : UIView

@property (nonatomic ,strong) NSMutableArray *copArr;
@property (nonatomic ,strong) Frame *currentFrame;

- (void)setMatFrame:(Frame *)frame;

@end
