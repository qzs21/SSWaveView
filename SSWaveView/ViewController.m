//
//  ViewController.m
//  SSWaveView
//
//  Created by Steven on 15/6/13.
//  Copyright (c) 2015年 Neva. All rights reserved.
//

#import "ViewController.h"
#import <SSWaveView.h>
#import <SSAccelerometerWaveView.h>

@interface ViewController ()

@property (strong, nonatomic) SSWaveView *waveView;

@property (strong, nonatomic) SSAccelerometerWaveView * acceView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.waveView = [[SSWaveView alloc] initWithFrame:self.view.bounds];
    [self.waveView startAnimate];
    [self.view addSubview:self.waveView];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.center = self.view.center;
    [button addTarget:self action:@selector(onButtonTouch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
//    SSAccelerometerWaveView *  aview = [[SSAccelerometerWaveView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    self.acceView = aview;
//    aview.backgroundColor = [UIColor redColor];
//    [self.view addSubview:aview];
}
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.waveView.frame = self.view.bounds;
    self.acceView.frame = self.view.bounds;
}
- (void)onButtonTouch
{
    if (self.waveView.isAnimation)
    {
        [self.waveView stopAnimate];
    }
    else
    {
        [self.waveView startAnimate];
    }
}

@end
