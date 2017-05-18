//
//  RefreshLayer.m
//  LayerDemo
//
//  Created by AH on 2017/5/17.
//  Copyright © 2017年 AH. All rights reserved.
//



#define AHColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define AHMarginRadio 0.03f
#define AHRadio 0.47f
#define AHCornerRadius 8.0f

#import "RefreshLayer.h"
#import <UIKit/UIKit.h>

static NSString *const shape_layer = @"shape_layer";
static NSString *const inside_rectangle_shapelayer = @"inside_rectangle_shapelayer";
static NSString *const line_one_shapelayer = @"line_one_shapelayer";
static NSString *const line_two_shapelayer = @"line_two_shapelayer";
static NSString *r_center0;
static NSString *r_center1;
static NSString *r_center2;
static NSString *r_center3;
@interface RefreshLayer ()

@property (nonatomic,strong) CAShapeLayer *shape_layer;
@property (nonatomic,strong) CAShapeLayer *inside_rectangle_shapelayer;
@property (nonatomic,assign) CGFloat front_progress_percent;
@property (nonatomic,strong) CALayer *inside_rectangle_layer;
@property (nonatomic,strong) CALayer *line_one_layer;
@property (nonatomic,strong) CALayer *line_two_layer;
@property (nonatomic,strong) CAShapeLayer *line_one_shapelayer;
@property (nonatomic,strong) CAShapeLayer *line_two_shapelayer;

@end

@implementation RefreshLayer{
    
    NSInteger _inside_index;
    CGPoint center0;
    CGPoint center1;
    CGPoint center2;
    CGPoint center3;
    CGPoint line_center1;
    CGPoint line_center2;
    CGPoint line_center3;
    CGPoint line_center4;
    CGPoint line_center5;
    CGPoint line_center6;
    CGFloat line_windth_0;
    CGFloat line_windth_1;
    CGFloat line_height ;
    CGFloat sizeW ;
    CGFloat sizeH ;
    CGFloat ratioW;
    CGFloat ratioH;
    CGFloat marginX ;
    CGFloat marginY ;
    CGFloat margin  ;
    CGFloat ratio   ;
    NSTimer *_LayerTimer;
    
}

- (instancetype)initWithRect:(CGRect)rect
{
    self = [super init];
    if (self) {
        self.bounds = CGRectMake(0, 0, rect.size.width, rect.size.height);
        self.position = CGPointMake(rect.origin.x, rect.origin.y);
        [self configdata];
    }
    return self;
}

- (void)configdata{
    
    [self assignmentdata];
    
    [self addSublayer:self.shape_layer];
    [self addSublayer:self.inside_rectangle_layer];
    
    [self addSublayer:self.line_two_layer];
    
    CAShapeLayer *line_two_shapelayer = self.line_two_shapelayer;
    line_two_shapelayer.path = [self get_line_two_path].CGPath;
    [self.line_two_layer addSublayer:self.line_two_shapelayer];
    
    [self addSublayer:self.line_one_layer];
    CAShapeLayer *line_one_shapelayer = self.line_one_shapelayer;
    line_one_shapelayer.path = [self get_line_one_path].CGPath;
    [self.line_one_layer addSublayer:self.line_one_shapelayer];
    
    

    
}
- (void)assignmentdata{
    
    self.backgroundColor = AHColor(242, 243, 244).CGColor;
    self.cornerRadius = AHCornerRadius;
    self.masksToBounds = YES;
    sizeW = self.bounds.size.width;
    sizeH = self.bounds.size.height;
    marginX =sizeW*AHMarginRadio;
    marginY = sizeH*AHMarginRadio;
    margin  = sizeW*AHMarginRadio;
    ratio = AHRadio;
    ratioW = sizeW*(1-ratio)*0.5;
    ratioH = sizeH*(1-ratio)*0.5;
    
    center0 = CGPointMake(ratioW, ratioH);
    center1 = CGPointMake(sizeW-ratioW, ratioH);
    center2 = CGPointMake(sizeW-ratioW, sizeH-ratioH);
    center3 = CGPointMake(ratioW, sizeH-ratioH);
    line_center1 = CGPointMake(center1.x-5, center1.y);
    line_center2 = CGPointMake((center2.x+center3.x)*0.5, center2.y);
    line_center3 = CGPointMake(center0.x+5, center2.y);
    line_center4 = CGPointMake(line_center2.x, center1.y);
    line_center5 = CGPointMake(line_center3.x, center1.y);
    line_center6 = CGPointMake(line_center1.x, center2.y);
    line_windth_0 = sizeW-2*(marginX+margin)-ratioW-marginX-20;
    //sizeW-6*marginX
    line_windth_1 = line_windth_0*2;
    line_height = sizeH*0.35;
    _LayerTimer =  [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(fun) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_LayerTimer forMode:NSDefaultRunLoopMode];
    [_LayerTimer setFireDate:[NSDate distantFuture]];
}

- (CAShapeLayer *)shape_layer{
    
    if (_shape_layer==nil) {
        
        _shape_layer = [self addBorderLayerToLayer];
//        UIBezierPath *_shape_layer_path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, sizeW, sizeH) cornerRadius:AHCornerRadius];
//        _shape_layer = [CAShapeLayer layer];
//        _shape_layer.strokeColor = AHColor(154, 154, 153).CGColor;
//        _shape_layer.fillColor = [UIColor clearColor].CGColor;
//        _shape_layer.lineCap = kCALineCapRound;
//        _shape_layer.lineJoin = kCALineJoinRound;
//        _shape_layer.lineWidth = 1.0f;
//        _shape_layer.path = [_shape_layer_path bezierPathByReversingPath].CGPath;
//        _shape_layer.strokeEnd = 0;
        
    }
    return _shape_layer;
}
- (CALayer *)inside_rectangle_layer{
    
    if (_inside_rectangle_layer==nil) {
        
        CGFloat inside_rectangle_path_w = ratioW-marginX;
        CGFloat inside_rectangle_path_h = ratioH-marginY;
        _inside_rectangle_layer = [CALayer layer];
        _inside_rectangle_layer.bounds = CGRectMake(0, 0, inside_rectangle_path_w, inside_rectangle_path_h);
        _inside_rectangle_layer.backgroundColor = AHColor(224, 224, 224).CGColor;
        _inside_rectangle_layer.position = center0;
        [_inside_rectangle_layer addSublayer:self.inside_rectangle_shapelayer];
    }
    return _inside_rectangle_layer;
}
- (CAShapeLayer *)inside_rectangle_shapelayer{
    
    if (_inside_rectangle_shapelayer==nil) {
        
        UIBezierPath *inside_rectangle_path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, ratioW-marginX, ratioH-marginY)];
        _inside_rectangle_shapelayer = [CAShapeLayer layer];
        _inside_rectangle_shapelayer.strokeColor = AHColor(154, 154, 153).CGColor;
        _inside_rectangle_shapelayer.fillColor = [UIColor clearColor].CGColor;
        _inside_rectangle_shapelayer.lineCap = kCALineCapRound;
        _inside_rectangle_shapelayer.lineJoin = kCALineJoinRound;
        _inside_rectangle_shapelayer.lineWidth = 1.0f;
        _inside_rectangle_shapelayer.path = inside_rectangle_path.CGPath;
        _inside_rectangle_shapelayer.strokeEnd = 0;
    }
    return _inside_rectangle_shapelayer;
}
- (CALayer *)line_two_layer{
    
    if (_line_two_layer==nil) {
        _line_two_layer = [CALayer layer];
        _line_two_layer.bounds = CGRectMake(0, 0, line_windth_1, line_height);
        _line_two_layer.position = line_center2;
        _line_two_layer.backgroundColor = [UIColor clearColor].CGColor;
        _line_two_layer.masksToBounds = YES;
    }
    return _line_two_layer;
}
- (CAShapeLayer *)line_two_shapelayer{
    
    if (_line_two_shapelayer==nil) {
        _line_two_shapelayer = [CAShapeLayer layer];
        _line_two_shapelayer.strokeColor = AHColor(154, 154, 153).CGColor;
        _line_two_shapelayer.fillColor =[UIColor clearColor].CGColor;
        _line_two_shapelayer.lineCap = kCALineCapRound;
        _line_two_shapelayer.lineJoin = kCALineJoinRound;
        _line_two_shapelayer.lineWidth = 1.0f;
        _line_two_shapelayer.strokeEnd = 0;
    }
    return _line_two_shapelayer;
}
- (CALayer *)line_one_layer{
    
    if (_line_one_layer==nil) {
        _line_one_layer = [CALayer layer];
        _line_one_layer.bounds = CGRectMake(0, 0, line_windth_0, line_height);
        _line_one_layer.position = line_center1;
        _line_one_layer.backgroundColor =[UIColor clearColor].CGColor;
        _line_one_layer.masksToBounds = YES;
    }
    return _line_one_layer;
}
- (CAShapeLayer *)line_one_shapelayer{
    
    if (_line_one_shapelayer==nil) {
        _line_one_shapelayer = [CAShapeLayer layer];
        _line_one_shapelayer.strokeColor = AHColor(154, 154, 153).CGColor;
        _line_one_shapelayer.fillColor =[UIColor clearColor].CGColor;
        _line_one_shapelayer.lineCap = kCALineCapRound;
        _line_one_shapelayer.lineJoin = kCALineJoinRound;
        _line_one_shapelayer.lineWidth = 1.0f;
        _line_one_shapelayer.strokeEnd = 0;
    }
    return _line_one_shapelayer;
}
- (CAShapeLayer*)addBorderLayerToLayer{
    
    CGFloat pointX = 0;  // 预留 可以在任意位置画出一边框
    CGFloat pointY = 0;  // 预留 可以在任意位置画出一边框
    CGFloat Radius = self.cornerRadius;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(pointX+sizeW-Radius, pointY)];
    [path addLineToPoint:CGPointMake(pointX+Radius, pointY)];
    [path addArcWithCenter:CGPointMake(pointX+Radius, pointY+Radius) radius:Radius startAngle:M_PI * 1.5 endAngle:M_PI clockwise:0];
    [path addLineToPoint:CGPointMake(pointX, pointY+sizeH-Radius)];
    [path addArcWithCenter:CGPointMake(pointX+Radius, pointY+sizeH-Radius) radius:Radius startAngle:M_PI endAngle:M_PI_2 clockwise:0];
    [path addLineToPoint:CGPointMake(pointX+sizeW-Radius, pointY+sizeH)];
    [path addArcWithCenter:CGPointMake(pointX+sizeW-Radius, pointY+sizeH-Radius) radius:Radius startAngle:M_PI_2 endAngle:0 clockwise:0];
    [path addLineToPoint:CGPointMake(pointX+sizeW, pointY+Radius)];
    [path addArcWithCenter:CGPointMake(pointX+sizeW-Radius, pointY+Radius) radius:Radius startAngle:0 endAngle:M_PI*1.5 clockwise:0];
    [path closePath];
    
    CAShapeLayer *shape_layer = [CAShapeLayer layer];
    shape_layer.strokeColor = AHColor(154, 154, 153).CGColor;
    shape_layer.fillColor = [UIColor clearColor].CGColor;
    shape_layer.lineCap = kCALineCapRound;
    shape_layer.lineJoin = kCALineJoinRound;
    shape_layer.lineWidth = 3.0f;
    shape_layer.path = path.CGPath;
    shape_layer.strokeEnd = 0;
    return shape_layer;
}

- (UIBezierPath*)get_line_two_path{
    
    UIBezierPath *line_two_path = [UIBezierPath bezierPath];
    [line_two_path moveToPoint:CGPointMake(0, self.line_two_layer.bounds.size.height*0.15)];
    [line_two_path addLineToPoint:CGPointMake(self.line_two_layer.bounds.size.width, self.line_two_layer.bounds.size.height*0.15)];
    [line_two_path moveToPoint:CGPointMake(0, self.line_two_layer.bounds.size.height*0.5)];
    [line_two_path addLineToPoint:CGPointMake(self.line_two_layer.bounds.size.width, self.line_two_layer.bounds.size.height*0.5)];
    [line_two_path moveToPoint:CGPointMake(0, self.line_two_layer.bounds.size.height*0.85)];
    [line_two_path addLineToPoint:CGPointMake(self.line_two_layer.bounds.size.width, self.line_two_layer.bounds.size.height*0.85)];
    return line_two_path;
}
- (UIBezierPath*)get_line_one_path{
    
    UIBezierPath *line_one_path = [UIBezierPath bezierPath];
    [line_one_path moveToPoint:CGPointMake(0, self.line_one_layer.bounds.size.height*0.15)];
    [line_one_path addLineToPoint:CGPointMake(self.line_two_layer.bounds.size.width, self.line_one_layer.bounds.size.height*0.15)];
    [line_one_path moveToPoint:CGPointMake(0, self.line_one_layer.bounds.size.height*0.5)];
    [line_one_path addLineToPoint:CGPointMake(self.line_two_layer.bounds.size.width, self.line_one_layer.bounds.size.height*0.5)];
    [line_one_path moveToPoint:CGPointMake(0, self.line_one_layer.bounds.size.height*0.85)];
    [line_one_path addLineToPoint:CGPointMake(self.line_two_layer.bounds.size.width, self.line_one_layer.bounds.size.height*0.85)];
    return line_one_path;
}

- (void)setRefreshprogress:(CGFloat)Refreshprogress{
    
    _Refreshprogress = Refreshprogress;
    
    if (self.front_progress_percent != Refreshprogress) {
        [self updateAnimationInLayer:self.shape_layer ForKey:shape_layer Progress:Refreshprogress];
        [self updateAnimationInLayer:self.inside_rectangle_shapelayer ForKey:inside_rectangle_shapelayer Progress:Refreshprogress];
        [self updateAnimationInLayer:self.line_one_shapelayer ForKey:line_one_shapelayer Progress:Refreshprogress];
        [self updateAnimationInLayer:self.line_two_shapelayer ForKey:line_two_shapelayer Progress:Refreshprogress];
        self.front_progress_percent =  Refreshprogress;
    }

}
- (void)updateAnimationInLayer:(CAShapeLayer*)layer ForKey:(NSString*)animationKey Progress:(CGFloat)Refreshprogress{
    
    layer.strokeEnd = Refreshprogress;
    [self.shape_layer removeAnimationForKey:animationKey];
    CABasicAnimation *animate_Progress = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animate_Progress.fromValue = @(self.front_progress_percent);
    animate_Progress.toValue = @(Refreshprogress);
    [self.shape_layer addAnimation:animate_Progress forKey:animationKey];
    
}
- (void)start{
//    [_LayerTimer setFireDate:[NSDate distantPast]];
    [self fun];
}
- (void)stop{
    [_LayerTimer setFireDate:[NSDate distantFuture]];
}
- (void)fun{
    
    _inside_index++;
    if (_inside_index>3) {
        _inside_index = 0;
    }
    NSValue *rec_layer_position = [self infoData][@"inside_rectangle_layer_position"][_inside_index];
    self.inside_rectangle_layer.position = rec_layer_position.CGPointValue;
    NSValue *one_layer_positon = [self infoData][@"line_one_layer_position"][_inside_index];
    self.line_one_layer.position= one_layer_positon.CGPointValue;
    NSValue *two_layer_positon = [self infoData][@"line_two_layer_position"][_inside_index];
    self.line_two_layer.position = two_layer_positon.CGPointValue;
    self.line_one_layer.bounds = CGRectMake(0, 0, _inside_index%2==0?line_windth_0:line_windth_1, line_height);
    self.line_two_layer.bounds = CGRectMake(0, 0, _inside_index%2?line_windth_0:line_windth_1, line_height);
}

- (NSDictionary*)infoData{
    
    NSDictionary *dic = @{
                          @"inside_rectangle_layer_position":@[[NSValue valueWithCGPoint:center0],[NSValue valueWithCGPoint:center1],[NSValue valueWithCGPoint:center2],[NSValue valueWithCGPoint:center3]],
                          @"line_one_layer_position":@[[NSValue valueWithCGPoint:line_center1],[NSValue valueWithCGPoint:line_center2],[NSValue valueWithCGPoint:line_center3],[NSValue valueWithCGPoint:line_center4]],
                          @"line_two_layer_position":@[[NSValue valueWithCGPoint:line_center2],[NSValue valueWithCGPoint:line_center5],[NSValue valueWithCGPoint:line_center4],[NSValue valueWithCGPoint:line_center6]],
                          };
    return dic;
}


@end
