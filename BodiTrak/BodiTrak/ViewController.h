//
//  ViewController.h
//  BodiTrak
//
//  Created by AnCheng on 9/23/16.
//  Copyright © 2016 AnCheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CopMapView.h"
#import "CopVelocityView.h"


@interface ViewController : UIViewController

@property (nonatomic ,assign) IBOutlet CopMapView *mapView;
@property (nonatomic ,assign) IBOutlet CopVelocityView *velocityView;

@property(nonatomic) CGAffineTransform origintransform;
@property(nonatomic) CGPoint originCenter;

@property (nonatomic) BODITRAK_STATUS boditrakStatus;

@end

