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

@end


@implementation SSWaveView

- (instancetype)init
{
    if (self = [super init])
    {
        [self initWaterView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initWaterView];
    }
    return self;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initWaterView];
}


- (void)initWaterView
{
    self.backgroundColor = [UIColor clearColor];
    
    self.waveHeight = 5.0;
    self.minAmplitude = 0.5f;
    self.maxAmplitude = 1.0f;
    self.wavelength = M_PI;
    self.progress = 0.5f;
    self.speed = 1.0;
    
    // TODO 按照设备性能进行调整
    self.fps = 50.0f;
}
- (BOOL)isAnimating
{
    return [self.timer isValid];
}
- (void)startAnimate
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0/self.fps
                                                  target:self
                                                selector:@selector(animateWave)
                                                userInfo:nil
                                                 repeats:YES];
}
- (void)stopAnimate
{
    [self.timer invalidate];
    self.timer = nil;
}

-(void)animateWave
{
    // 计算当前震幅
    if (mCurrentYAmplitude > self.maxAmplitude)
    {
        mIsPlus = NO;
        mCurrentYAmplitude = self.maxAmplitude;
    }
    if (mCurrentYAmplitude < self.minAmplitude)
    {
        mIsPlus = YES;
        mCurrentYAmplitude = self.minAmplitude;
    }
    if (mCurrentXOffset > 2 * M_PI)
    {
        mCurrentXOffset = 0;
    }
    
    mCurrentYAmplitude += (mIsPlus ? 1.0 : -1.0) * (self.maxAmplitude - self.minAmplitude) / self.fps * self.speed;
    mCurrentXOffset += (2 * M_PI) * ( 1.0 / self.fps) * self.speed;
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 填充背景色
    [self.backgroundColor setFill];
    CGContextFillRect(context, rect);
    
    // 画水
    UIColor * fillColor = self.fillColor;
    if (self.fillColor == nil)
    {
        fillColor = [UIColor colorWithRed:86/255.0f green:202/255.0f blue:139/255.0f alpha:1];
    }
    CGContextSetLineWidth(context, 1);
    CGContextSetFillColorWithColor(context, [fillColor CGColor]);
    
    CGFloat currentLinePointY = self.progress*self.frame.size.height;
    CGFloat y = self.frame.size.height;
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, y);
    for(CGFloat x = 0; x <= self.frame.size.width; x++)
    {
        // 计算出 2 * M_PI 在View中的长度
        CGFloat one_x =  self.frame.size.width / (self.wavelength / (2*M_PI));
        // 计算出 在 0~2*M_PI 范围中，x轴的位置
        CGFloat cell_x = (int)x % (int)one_x * ( x > 0 ? 1.0 : -1.0);
        // 计算出当前弧度
        CGFloat radian = 2 * M_PI * (cell_x/one_x);
        // 算出y轴的值
        y = mCurrentYAmplitude * sin(radian+mCurrentXOffset) * self.waveHeight + (self.waveHeight + self.frame.size.height * (1.0-self.progress));
        
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, rect.size.width, rect.size.height);
    CGPathAddLineToPoint(path, nil, 0, rect.size.height);
    CGPathAddLineToPoint(path, nil, 0, currentLinePointY);
    
    CGContextAddPath(context, path);
    CGContextFillPath(context);
    CGContextDrawPath(context, kCGPathStroke);
    CGPathRelease(path);
    
}

@end
