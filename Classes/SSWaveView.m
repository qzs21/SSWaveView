//
//  SSWaveView.m
//  SSWaveView
//
//  Created by Steven on 15/6/13.
//  Copyright (c) 2015年 Neva. All rights reserved.
//

#import "SSWaveView.h"

@interface SSWaveView()
{
    // 当前y轴震幅
    CGFloat mCurrentYAmplitude;
    
    // 当前x轴位移
    CGFloat mCurrentXOffset;
    
    // 变换系数，是否为加
    BOOL mIsPlus:YES;
    
    // 是否已经初始化
    BOOL mIsInited;
}

@property (nonatomic, strong) NSTimer * timer; // 动画定时器

@property (nonatomic, strong) CAShapeLayer *circleLayer;

@end


@implementation SSWaveView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initWaveView];
    }
    return self;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initWaveView];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.circleLayer.frame = self.bounds;
}

- (void)initWaveView
{
    self.backgroundColor = [UIColor clearColor];
    
    self.minAmplitude = 0.5f;
    self.maxAmplitude = 1.0f;
    self.progress = 0.5f;
    
    
    self.waveSepeed = 1;
    self.controllWaveHeight = 20.f;
    self.waveWidth = 180.f;
    
    
    
    /****** 添加绘制图层 ******/
    self.circleLayer = [CAShapeLayer layer];
    self.circleLayer.path          = [self pathWith:-1].CGPath;
    self.circleLayer.fillColor     = [UIColor redColor].CGColor;
    self.circleLayer.strokeColor   = [UIColor redColor].CGColor;
    self.circleLayer.lineWidth     = 2.f;
    [self.layer addSublayer:self.circleLayer];
}

- (BOOL)isAnimating
{
    return [self.timer isValid];
}
- (void)startAnimate
{
    _isAnimation = YES;
    [self animateWave];
}
- (void)stopAnimate
{
    _isAnimation = NO;
}

-(void)animateWave
{
    static int i = 0;
    
    CABasicAnimation *circleAnim = [CABasicAnimation animationWithKeyPath:@"path"];
    circleAnim.removedOnCompletion = NO;
    circleAnim.duration  = 0.5;
    circleAnim.timingFunction = [CAMediaTimingFunction functionWithName:@"linear"];
    int num = (int)(4/self.waveSepeed);
    if (i% num == 0) {
        self.circleLayer.path = [self pathWith:-1].CGPath;
    }
    circleAnim.fromValue = (__bridge id)(self.circleLayer.path);
    circleAnim.toValue   = (__bridge id)[self pathWith:i%num].CGPath;
    circleAnim.delegate = self;
    self.circleLayer.path = [self pathWith:i%num].CGPath;
    [self.circleLayer addAnimation:circleAnim forKey:@"animateCirclePath"];
    
    i++;

}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {

    if (flag && self.isAnimation) {
        [self animateWave];
    }
}

- (UIBezierPath *)pathWith:(int)tag {

    CGFloat height = self.frame.size.height;
    CGFloat py = height*self.progress;
    CGFloat px = - (tag+1) * self.waveWidth * self.waveSepeed;
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(px, py)];
    BOOL isAdd = YES;
    while (px<self.frame.size.width+((4/self.waveSepeed)-tag) * self.waveWidth * self.waveSepeed) {
        px += self.waveWidth;
        [bezierPath addQuadCurveToPoint:CGPointMake(px, py) controlPoint:CGPointMake(px-self.waveWidth/2.0, py+(isAdd?self.controllWaveHeight:-self.controllWaveHeight)*(tag%1==0? self.maxAmplitude:self.minAmplitude))];
        isAdd = !isAdd;
    }
    [bezierPath addLineToPoint:CGPointMake(px, height)];
    [bezierPath addLineToPoint:CGPointMake(- (tag+1) * self.waveWidth, height)];
    [bezierPath addLineToPoint:CGPointMake(- (tag+1) * self.waveWidth, py)];
    [bezierPath closePath];
    
    return bezierPath;
}

@end
