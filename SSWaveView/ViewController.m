//
//  ViewController.m
//  SSWaveView
//
//  Created by Steven on 15/6/13.
//  Copyright (c) 2015年 Neva. All rights reserved.
//

#import "ViewController.h"
#import <SSWaveView.h>

@interface ViewController ()

@property (strong, nonatomic) SSWaveView *waveView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    SSWaveView * view = [[SSWaveView alloc] initWithFrame:self.view.bounds];
    //    view.progress = 0.7;
    //    view.horizontalAngle = 2 * M_PI;
    //    view.wavelength =  M_PI_2;//2 * M_PI;
    view.speed = 0.8;
    [view startAnimate];
    
    [self.view addSubview:view];
    self.waveView = view;
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.center = self.view.center;
    [button addTarget:self action:@selector(onButtonTouch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.waveView.frame = self.view.bounds;
}
- (void)onButtonTouch
{
    if (self.waveView.isAnimating)
    {
        [self.waveView stopAnimate];
    }
    else
    {
        [self.waveView startAnimate];
    }
}

@end
