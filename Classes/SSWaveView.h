//
//  SSWaveView.h
//  SSWaveView
//
//  Created by Steven on 15/6/13.
//  Copyright (c) 2015年 Neva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSWaveView : UIView

/// 装满程度，默认0.5f
@property (nonatomic, assign) CGFloat progress;

/// 填充颜色
@property (nonatomic, strong) UIColor * fillColor;

/// 最小震幅，默认是0.5f
@property (nonatomic, assign) CGFloat minAmplitude;

/// 最大震幅，默认是1.0f
@property (nonatomic, assign) CGFloat maxAmplitude;




///波浪速度（向左）
@property (nonatomic, assign) CGFloat waveSepeed;
///波峰控制点高度
@property (nonatomic, assign) CGFloat controllWaveHeight;
///波长（宽度）
@property (nonatomic, assign) CGFloat waveWidth;
///是否动画
@property (nonatomic, assign, readonly) BOOL isAnimation;


/**
 *  开启动画，如果停止使用，一定要记得调用stopAnimate，否则内存不会被释放
 */
- (void)startAnimate;

/**
 *  停止动画
 */
- (void)stopAnimate;

@end
