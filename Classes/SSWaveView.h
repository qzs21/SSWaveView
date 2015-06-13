//
//  SSWaveView.h
//  SSWaveView
//
//  Created by Steven on 15/6/13.
//  Copyright (c) 2015年 Neva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSWaveView : UIView

/// 每秒播放多少桢，默认按照设备性能进行调整，不可为0！
@property (nonatomic, assign) CGFloat fps;

/// 动画速度，默认是1.0f
@property (nonatomic, assign) CGFloat speed;

/// 水平角度偏移(单位弧度)，默认是0
@property (nonatomic, assign) CGFloat horizontalAngle;

/// 装满程度，默认0.5f
@property (nonatomic, assign) CGFloat progress;

/// 填充颜色
@property (nonatomic, strong) UIColor * fillColor;

/// 波峰的高度，默认是5.0f
@property (nonatomic, assign) CGFloat waveHeight;

/// 最小震幅，默认是0.5f
@property (nonatomic, assign) CGFloat minAmplitude;

/// 最大震幅，默认是1.0f
@property (nonatomic, assign) CGFloat maxAmplitude;

/// 波长(单位弧度)，默认是 M_PI
@property (nonatomic, assign) CGFloat wavelength;

/// 是否已经开启动画
@property (nonatomic, readonly) BOOL isAnimating;

/**
 *  开启动画，如果停止使用，一定要记得调用stopAnimate，否则内存不会被释放
 */
- (void)startAnimate;

/**
 *  停止动画
 */
- (void)stopAnimate;

@end
