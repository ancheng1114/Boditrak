//
//  ViewController.m
//  BodiTrak
//
//  Created by AnCheng on 9/23/16.
//  Copyright © 2016 AnCheng. All rights reserved.
//

#import "ViewController.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

#define SystemSharedServices [SystemServices sharedServices]

@interface ViewController ()
{
    NSURL *secondPath;
}

@property (nonatomic ,weak) EventSource *source;

@end

@implementation ViewController

@synthesize source;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH-mm-ss.SSS"];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if (source) [source close];
}

@end
