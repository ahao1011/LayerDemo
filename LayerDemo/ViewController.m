//
//  ViewController.m
//  LayerDemo
//
//  Created by AH on 2017/5/15.
//  Copyright © 2017年 AH. All rights reserved.
//

#import "ViewController.h"
#import "RefreshLayer.h"

@interface ViewController ()


@property (nonatomic,strong) RefreshLayer *reflayer;




@end

@implementation ViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.reflayer =[[RefreshLayer alloc]initWithRect:CGRectMake(200, 200, 120, 120)];
    [self.view.layer addSublayer:self.reflayer];
    
}

- (IBAction)test:(UISlider *)sender {
    
    self.reflayer.Refreshprogress = sender.value;
    
}
- (IBAction)AnimationStart:(id)sender {
    [self.reflayer start];
}
- (IBAction)AnimationStop:(id)sender {
    [self.reflayer stop];
    
}

//页面消失，进入后台不显示该页面，关闭定时器
-(void)viewDidDisappear:(BOOL)animated
{
    //关闭定时器
     [self.reflayer stop];
}





@end
