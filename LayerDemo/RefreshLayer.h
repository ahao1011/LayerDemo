//
//  RefreshLayer.h
//  LayerDemo
//
//  Created by AH on 2017/5/17.
//  Copyright © 2017年 AH. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>


@interface RefreshLayer : CALayer
// 介于0~1之间
@property (nonatomic,assign) CGFloat Refreshprogress;
- (instancetype)initWithRect:(CGRect)rect;
- (void)start;
- (void)stop;

@end
