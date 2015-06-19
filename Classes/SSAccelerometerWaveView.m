//
//  SSAccelerometerWaveView.m
//  Pods
//
//  Created by Steven on 15/6/13.
//
//

#import "SSAccelerometerWaveView.h"
#import <CoreMotion/CoreMotion.h>
#import "SSWaveView.h"

@interface SSAccelerometerWaveView()

@property (nonatomic, strong) CMMotionManager * motionManager;

@property (nonatomic, strong) SSWaveView * waveView;

@end

@implementation SSAccelerometerWaveView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initAccelerometerWaveView];
    }
    return self;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initAccelerometerWaveView];
}

- (void)initAccelerometerWaveView
{
    // Add wave view.
//    self.waveView = [[SSWaveView alloc] init];
//    self.waveView.progress = 0.5;
//    [self.waveView startAnimate];
//    [self addSubview:self.waveView];
    
    CMMotionManager *motionManager = [[CMMotionManager alloc] init];
    self.motionManager = motionManager;
    self.motionManager.accelerometerUpdateInterval = 0.1;
    
    
    // 加速度器是否可用
    if ([self.motionManager isAccelerometerAvailable])
    {
        NSLog(@"Accelerometer is available.");
    }
    else
    {
        NSLog(@"Accelerometer is not available.");
    }
    // 加速器是否已经激活
    if ([self.motionManager isAccelerometerActive])
    {
        NSLog(@"Accelerometer is active.");
    }
    else
    {
        NSLog(@"Accelerometer is not active.");
    }
    
    __weak SSAccelerometerWaveView * weakSelf = self;
    if (motionManager.isAccelerometerAvailable)
    {
//        motionManager.accelerometerUpdateInterval = 1.0 / self.waveView.fps;
        [motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue]
                                            withHandler:^(CMAccelerometerData *accelerometerData, NSError *error)
         {
             if (!error)
             {
                 // 计算倾斜角度
                 double angle = atan2(accelerometerData.acceleration.x, accelerometerData.acceleration.y);
                 NSLog(@"angle: %f", angle);
                 
                 __strong SSAccelerometerWaveView * strongSelf = weakSelf;
                 strongSelf.waveView.transform = CGAffineTransformMakeRotation(angle+M_PI);
             }
         }];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.waveView.frame = self.bounds;
}


- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];    
}


@end
